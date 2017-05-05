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
        self.navigationController?.isNavigationBarHidden = false

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

        listObserve.observeNext(with: { stationList in
            self.addingAnnotation(stationList)
        })
        
        let locationButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        locationButton.setImage(UIImage(named: "location"), for: UIControlState())
        locationButton.addTarget(self, action: #selector(HomeViewController.setMapCenterToCurrentLocation), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: locationButton)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshList()
    }

    func setMapCenter(_ location: CLLocationCoordinate2D) {
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

    func addingAnnotation(_ list: StationList) {
        for station in list.lists {
            let annotation = DDAnnotation(station: station)
            mapView.addAnnotation(annotation)
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? DDAnnotation {
            let reuseId = "bikePin"
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
            if view == nil {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                view!.canShowCallout = true
                view!.calloutOffset = CGPoint(x: -5, y: 5)
            } else {
                view!.annotation = annotation
            }
            view?.backgroundColor = UIColor.clear
            view!.image = annotation.image
            return view
        }
        return nil
    }

    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        for view in views {
            if (view.annotation?.isKind(of: MKUserLocation.self) == true) {
                self.mapView.bringSubview(toFront: view)
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation.next((manager.location?.coordinate)!)
    }
}
