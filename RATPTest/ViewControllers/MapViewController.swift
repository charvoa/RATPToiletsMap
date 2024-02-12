//
//  MapViewController.swift
//  RATPTest
//
//  Created by Nicolas Charvoz on 11/02/2024.
//

import Foundation
import UIKit
import MapKit

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
extension MapViewController: MapViewModelProtocol, MKMapViewDelegate {
    func didEndRefreshing() {
        DispatchQueue.main.async {
            self.viewModel?.items?
                .forEach {
                    if let coordinates = $0.coordinates {
                        let annotation = ToiletteModelAnnotation(title: $0.title, coordinates: coordinates, isOpen: $0.isOpen)
                        self.mapView.addAnnotation(annotation)
                    }
                }
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? ToiletteModelAnnotation else { return nil }
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "MyMarker")
        annotationView.markerTintColor = annotation.tintColor
        return annotationView
    }
}

// MARK: - Setup
private extension MapViewController {
    func setup() {
        viewModel?.delegate = self
        mapView.showsUserLocation = true
        mapView.delegate = self
    }

    func centerMap() {
        let region = MKCoordinateRegion(center: LocationService.centerOfParis, latitudinalMeters: CLLocationDistance(exactly: 5000)!, longitudinalMeters: CLLocationDistance(exactly: 5000)!)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
}
