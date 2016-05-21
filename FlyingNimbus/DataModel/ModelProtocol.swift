//
//  ModelProtocol.swift
//  FlyingNimbus
//
//  Created by Do Duc on 21/05/16.
//  Copyright © 2016 Do Duc. All rights reserved.
//

import UIKit

protocol BikeStationProtocol {
    func getName() -> String
    func getID() -> String
    func getLat() -> Double
    func getLon() -> Double
    func getSpacesAvailable() -> Int
    func getBikesAvailable() -> Int
}
