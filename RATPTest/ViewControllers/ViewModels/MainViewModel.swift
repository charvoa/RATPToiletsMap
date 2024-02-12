//
//  MainViewModel.swift
//  RATPTest
//
//  Created by Nicolas Charvoz on 12/02/2024.
//

import Foundation
import UIKit
import CoreLocation

protocol MainViewModelProtocol: AnyObject {
    func didEndRefreshing()
    func shouldShowEmptyView(show: Bool)
}

enum FilterType {
    case pmr
    case open
    case babyRelay
}

final class MainViewModel {
    enum Section {
        case main
    }

    var filteredItems: [ToiletteModel] {
        switch filter {
        case .pmr:
            return items.filter { $0.hasPmrAccess }
        case .open:
            return items.filter { $0.isOpen == true }
        case .babyRelay:
            return items.filter { $0.hasBabyRelay }
        case nil:
            return items
        }
    }

    private var items: [ToiletteModel]
    var cursor: Int
    var filter: FilterType? {
        didSet {
            filterDataSource()
        }
    }

    private var loadedOnce = false

    weak var delegate: MainViewModelProtocol?

    private let networkManager: NetworkProtocol
    private let locationService = LocationService()

    private var snapshot = NSDiffableDataSourceSnapshot<Section, ToiletteModel>()
    private var dataSource: UITableViewDiffableDataSource<Section, ToiletteModel>?

    var emptyViewMessage: String {
        return loadedOnce ? "Aucun élément correspondant à votre recherche ..." : "Chargement en cours ..."
    }

    init() {
        self.networkManager = NetworkManager()
        self.cursor = 0
        self.items = []
        self.locationService.delegate = self
    }

    func prepareMapViewModel() -> MapViewModel {
        return MapViewModel(networkManager: networkManager)
    }

    func distanceFromCurrentPosition(_ position: CLLocationCoordinate2D?) -> Double? {
        guard let position, let currentPosition = locationService.currentPosition() else {
            return nil
        }

        return locationService.distance(from: currentPosition, to: position)
    }

    func refresh() {
        Task {
            guard let newItems = await getItems(from: 0) else { return }

            cursor = 0
            items = newItems

            snapshot.deleteAllItems()
            snapshot.appendSections([.main])
            snapshot.appendItems(items)
            updateDataSource()
        }
    }

    func fetch(from: Int = 0) {
        Task {
            guard let newItems = await getItems(from: from) else { return }

            loadedOnce = true
            cursor = from

            items.append(contentsOf: newItems)
            snapshot.appendItems(newItems)
            updateDataSource()
        }
    }

    private func getItems(from: Int = 0) async -> [ToiletteModel]? {
        return try? await networkManager.fetchData(from: from, limit: 20).compactMap { ToiletteModel(from: $0) }
    }
}

// MARK: - DiffableDataSource

extension MainViewModel {
    func makeDataSource(withTableView tableView: UITableView) -> UITableViewDiffableDataSource<Section, ToiletteModel>? {
        dataSource = UITableViewDiffableDataSource(tableView: tableView) { [weak self] tableView, indexPath, toilette in
            let cell = tableView.dequeueReusableCell(for: indexPath) as ToiletteTableViewCell
            cell.configure(with: toilette, distance: self?.distanceFromCurrentPosition(toilette.coordinates))
            return cell
        }

        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        updateDataSource()

        return dataSource
    }

    func updateDataSource() {
        DispatchQueue.main.async {
            self.delegate?.shouldShowEmptyView(show: self.snapshot.itemIdentifiers.isEmpty)
            self.dataSource?.apply(self.snapshot, animatingDifferences: true)
            self.delegate?.didEndRefreshing()
        }
    }

    func filterDataSource() {
        snapshot.deleteAllItems()
        snapshot.appendSections([.main])
        snapshot.appendItems(filteredItems, toSection: .main)
        updateDataSource()
    }
}

// MARK: - Location Service
extension MainViewModel: LocationServiceProtocol {
    func locationAuthorized() {
        self.delegate?.didEndRefreshing()
    }
}
