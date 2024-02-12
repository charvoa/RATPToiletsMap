//
//  MapViewModel.swift
//  RATPTest
//
//  Created by Nicolas Charvoz on 12/02/2024.
//

import Foundation

protocol MapViewModelProtocol: AnyObject {
    func didEndRefreshing()
}

class MapViewModel {
    var items: [ToiletteModel]?

    weak var delegate: MapViewModelProtocol?

    private var networkManager: NetworkProtocol

    init(networkManager: NetworkProtocol) {
        self.networkManager = networkManager
    }

    func fetchAll() {
        Task {
            items = try? await networkManager.fetchData(from: 0, limit: 800).compactMap { ToiletteModel(from: $0) }
            delegate?.didEndRefreshing()
        }
    }
}
