//
//  BikeStationModel.swift
//  FlyingNimbus
//
//  Created by Do Duc on 21/05/16.
//  Copyright © 2016 Do Duc. All rights reserved.
//

import UIKit
import Gloss

class BikeStation: Decodable, BikeStationProtocol {
    let allowDropoff: Bool?
    let bikesAvailable: Int?
    let id: String!
    let name: String?
    let realTimeData: Bool?
    let spacesAvailable: Int?
    let lat: Double?
    let lon: Double?

    required init?(json: JSON) {
        guard let id: String = "id" <~~ json
            else { return nil }

        self.id = id
        self.allowDropoff = "allowDropoff" <~~ json
        self.bikesAvailable = "bikesAvailable" <~~ json
        self.name = "name" <~~ json

        let realTimeData: NSNumber = ("realTimeData" <~~ json) ?? 0
        self.realTimeData = realTimeData.boolValue

        self.spacesAvailable = "spacesAvailable" <~~ json
        self.lat = "x" <~~ json
        self.lon = "y" <~~ json
    }

    func getID() -> String {
        return self.id
    }

    func getName() -> String {
        return self.name ?? "Banana city"
    }

    func getLat() -> Double {
        return self.lat ?? 0
    }

    func getLon() -> Double {
        return self.lon ?? 0
    }

    func getSpacesAvailable() -> Int {
        return self.spacesAvailable ?? 0
    }

    func getBikesAvailable() -> Int {
        return self.bikesAvailable ?? 0
    }
}

class StationList: Decodable {
    let lists: [BikeStation]!

    init() {
        lists = []
    }

    required init?(json: JSON) {
        guard let lists: [JSON] = "stations" <~~ json
            else { return nil }
        var tempList: [BikeStation] = []
        for sJson in lists {
            let station: BikeStation = BikeStation(json: sJson)!
            tempList.append(station)
        }

        self.lists = tempList
    }
}
