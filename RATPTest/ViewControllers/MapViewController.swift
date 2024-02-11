//
//  MapViewController.swift
//  RATPTest
//
//  Created by Nicolas Charvoz on 11/02/2024.
//

import Foundation
import UIKit
import MapKit

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

final class MapViewController: UIViewController {

    @IBOutlet private weak var mapView: MKMapView!

    var viewModel: MapViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        centerMap()
        viewModel?.fetchAll()
    }
}

// MARK: - MapViewModelProtocol
extension MapViewController: MapViewModelProtocol {
    func didEndRefreshing() {
        DispatchQueue.main.async {
            self.viewModel?.items?
                .forEach {
                    if let coordinates = $0.coordinates {
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = coordinates
                        self.mapView.addAnnotation(annotation)
                    }
                }
        }
    }
}

// MARK: - Setup
private extension MapViewController {
    func setup() {
        viewModel?.delegate = self
        mapView.showsUserLocation = true
    }

    func centerMap() {
        let region = MKCoordinateRegion(center: LocationService.centerOfParis, latitudinalMeters: CLLocationDistance(exactly: 5000)!, longitudinalMeters: CLLocationDistance(exactly: 5000)!)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
}
