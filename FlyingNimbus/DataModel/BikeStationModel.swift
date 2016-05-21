//
//  BikeStationModel.swift
//  FlyingNimbus
//
//  Created by Do Duc on 21/05/16.
//  Copyright © 2016 Do Duc. All rights reserved.
//

import UIKit
import Gloss

class BikeStation: Decodable {
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
