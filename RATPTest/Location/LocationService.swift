//
//  LocationService.swift
//  RATPTest
//
//  Created by Nicolas Charvoz on 10/02/2024.
//

import Foundation
import CoreLocation

protocol LocationServiceProtocol: AnyObject {
    func locationAuthorized()
}

class LocationService: NSObject {
    private let locationManager: CLLocationManager?

    weak var delegate: LocationServiceProtocol?

    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager?.delegate = self
    }
}

// MARK: - Helper
extension LocationService {
    class func displayDistance(_ value: Double) -> String {
        let measurement = Measurement(value: value, unit: UnitLength.meters).converted(to: value > 100 ? .kilometers : .meters)

        let mf = MeasurementFormatter()
        mf.unitOptions = .providedUnit
        mf.unitStyle = .medium
        mf.numberFormatter.maximumFractionDigits = 1
        return mf.string(from: measurement)
    }
}

extension LocationService {
    func currentPosition() -> CLLocationCoordinate2D? {
        return locationManager?.location?.coordinate
    }

    func distance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> Double {
        return CLLocation(latitude: from.latitude, longitude: from.longitude).distance(from: CLLocation(latitude: to.latitude, longitude: to.longitude))
    }
}

private extension LocationService {
    func requestAuthorization() {
        locationManager?.requestWhenInUseAuthorization()
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager?.startUpdatingLocation()
            delegate?.locationAuthorized()
        } else {
            requestAuthorization()
        }
    }
}
