//
//  HomeViewController.swift
//  FlyingNimbus
//
//  Created by Do Duc on 21/05/16.
//  Copyright © 2016 Do Duc. All rights reserved.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {
    let mapview: MKMapView = MKMapView(frame: CGRect(x: 0, y: 0, width: CGSize.screenWidth(), height: CGSize.screenHeight()))
    var lists: StationList = StationList()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        self.view.addSubview(mapview)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshList()
    }

    func refreshList() {
        WebServices.sharedInstance.fetchStationData().then { (lists) in
            self.lists = lists
        }
    }
}
