//
//  DDAnnotation.swift
//  FlyingNimbus
//
//  Created by Do Duc on 21/05/16.
//  Copyright © 2016 Do Duc. All rights reserved.
//

import UIKit
import MapKit

class DDAnnotation: MKPointAnnotation {
    var image: UIImage!

    init(station: BikeStation) {
        super.init()
        self.coordinate = CLLocationCoordinate2D(latitude: station.getLat(), longitude: station.getLon())
        self.title = station.getName()
        self.subtitle = "bikes available: " + String(station.getBikesAvailable()) + " spaces available: " + String(station.getSpacesAvailable())
        self.image = UIImage(named: "bike_icon")
    }
}
