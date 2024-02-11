//
//  ViewController.swift
//  RATPTest
//
//  Created by Nicolas Charvoz on 10/02/2024.
//

import UIKit
import CoreLocation
import SwiftUI

protocol MainViewModelProtocol: AnyObject {
    func didEndRefreshing()
}

enum FilterType {
    case pmr
    case open
    case babyRelay
}

final class MainViewModel {
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
            delegate?.didEndRefreshing()
        }
    }

    private var loadedOnce = false

    weak var delegate: MainViewModelProtocol?

    private let networkManager: NetworkProtocol
    private let locationService = LocationService()

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

            DispatchQueue.main.async {
                self.delegate?.didEndRefreshing()
            }
        }
    }

    func fetch(from: Int = 0) {
        Task {
            guard let newItems = await getItems(from: from) else { return }

            loadedOnce = true
            cursor = from

            items.append(contentsOf: newItems)

            DispatchQueue.main.async {
                self.delegate?.didEndRefreshing()
            }
        }
    }

    private func getItems(from: Int = 0) async -> [ToiletteModel]? {
        return try? await networkManager.fetchData(from: from, limit: 20)
    }
}

// MARK: - Location Service
extension MainViewModel: LocationServiceProtocol {
    func locationAuthorized() {
        self.delegate?.didEndRefreshing()
    }
}

class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var filterButton: UIBarButtonItem!

    private lazy var refreshControl = UIRefreshControl()

    private let viewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        load()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let mapViewController = segue.destination as? MapViewController {
            let mapViewModel = viewModel.prepareMapViewModel()
            mapViewController.viewModel = mapViewModel
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.filteredItems.count == 0 {
            self.tableView.setEmptyMessage(viewModel.emptyViewMessage)
        } else {
            self.tableView.restore()
        }

        return viewModel.filteredItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.filteredItems[indexPath.row]

        let cell = tableView.dequeueReusableCell(for: indexPath) as ToiletteTableViewCell
        cell.configure(with: item, distance: viewModel.distanceFromCurrentPosition(item.coordinates))
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            viewModel.fetch(from: viewModel.cursor + indexPath.row)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = viewModel.filteredItems[indexPath.row]
        let viewModel = DetailsViewModel(toiletteModel: item)
        let rootView = DetailsView(viewModel: viewModel)

        let viewController = UIHostingController(rootView: rootView)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - View Setup
private extension ViewController {
    func setup() {
        viewModel.delegate = self
        setupTableView()
        setupRefreshControl()
        setupFilterMenu()
    }

    func setupFilterMenu() {
        let pmrFilterItem = UIAction(title: "Accès PMR", image: viewModel.filter == .pmr ? UIImage(resource: ImageResource.checkmarkDone) : nil) { [weak self] _ in
            self?.viewModel.filter = .pmr
            self?.setupFilterMenu()
        }

        let openFilterItem = UIAction(title: "Ouvert", image: viewModel.filter == .open ? UIImage(resource: ImageResource.checkmarkDone) : nil) { [weak self] _ in
            self?.viewModel.filter = .open
            self?.setupFilterMenu()
        }

        let babyRelayFilterItem = UIAction(title: "Relai Bébé", image: viewModel.filter == .babyRelay ? UIImage(resource: ImageResource.checkmarkDone) : nil) { [weak self] _ in
            self?.viewModel.filter = .babyRelay
            self?.setupFilterMenu()
        }

        let resetItem = UIAction(title: "Par défaut") { [weak self] _ in
            self?.viewModel.filter = nil
            self?.setupFilterMenu()
        }

        let menu = UIMenu(title: "My Menu", options: .displayInline, children: [pmrFilterItem, openFilterItem, babyRelayFilterItem, resetItem])

        filterButton.menu = menu
    }

    func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "👀")
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(cellType: ToiletteTableViewCell.self)
    }
}


// MARK: - Data Handling
extension ViewController: MainViewModelProtocol {
    func didEndRefreshing() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }

    @objc func refresh() {
        refreshControl.beginRefreshing()
        viewModel.refresh()
    }

    func load() {
        refreshControl.beginRefreshing()
        viewModel.fetch()
    }
}
