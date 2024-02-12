//
//  ToiletteModelAnnotation.swift
//  RATPTest
//
//  Created by Nicolas Charvoz on 12/02/2024.
//

import MapKit

class ToiletteModelAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var tintColor: UIColor

    init(title: String?, coordinates: CLLocationCoordinate2D, isOpen: Bool?) {
        self.title = title
        self.coordinate = coordinates

        if let isOpen {
            tintColor = isOpen ? UIColor.systemGreen : UIColor.red
        } else {
            tintColor = UIColor.blue
        }
    }
}
