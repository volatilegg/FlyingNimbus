//
//  HomeViewController.swift
//  FlyingNimbus
//
//  Created by Do Duc on 21/05/16.
//  Copyright © 2016 Do Duc. All rights reserved.
//

import UIKit
import MapKit
import Bond

class HomeViewController: UIViewController, MKMapViewDelegate {
    let mapView: MKMapView = MKMapView(frame: CGRect(x: 0, y: 0, width: CGSize.screenWidth(), height: CGSize.screenHeight()))
    var listObserve: Observable<StationList> = Observable(StationList())
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        mapView.delegate = self
        self.view.addSubview(mapView)

        let location = CLLocationCoordinate2D(
            latitude: 60.1699,
            longitude: 24.9384
        )

        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        let curAnn: MKPointAnnotation = MKPointAnnotation()
        curAnn.coordinate = location
        curAnn.title = "djkcbsdkj"
        mapView.addAnnotation(curAnn)
        listObserve.observe { stationList in
            self.addingAnnotation(stationList)
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshList()
    }

    func refreshList() {
        WebServices.sharedInstance.fetchStationData().then { (lists) in
            self.listObserve.next(lists)
        }
    }

    func addingAnnotation(list: StationList) {
        for station in list.lists {
            let annotation = DDAnnotation(station: station)
            mapView.addAnnotation(annotation)
        }
    }

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? DDAnnotation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
            }
            return view
        }
        return nil
    }
}
