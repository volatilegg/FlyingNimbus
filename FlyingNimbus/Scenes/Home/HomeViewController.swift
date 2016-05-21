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

let centerHelsinki = CLLocationCoordinate2D(latitude: 60.1699, longitude: 24.9384)

class HomeViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    let mapView: MKMapView = MKMapView(frame: CGRect(x: 0, y: 0, width: CGSize.screenWidth(), height: CGSize.screenHeight()))
    var listObserve: Observable<StationList> = Observable(StationList())
    var currentLocation: Observable<CLLocationCoordinate2D> = Observable(centerHelsinki)
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false

        self.mapView.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        mapView.showsUserLocation = true
        setMapCenter(centerHelsinki)
        self.view.addSubview(mapView)

        listObserve.observe { stationList in
            self.addingAnnotation(stationList)
        }
        let locationButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        locationButton.setImage(UIImage(named: "location"), forState: .Normal)
        locationButton.addTarget(self, action: #selector(HomeViewController.setMapCenterToCurrentLocation), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: locationButton)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshList()
    }

    func setMapCenter(location: CLLocationCoordinate2D) {
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func setMapCenterToCurrentLocation() {
        setMapCenter(self.currentLocation.value)
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
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
            }
            return view
        }
        return nil
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation.next((manager.location?.coordinate)!)
    }
}
