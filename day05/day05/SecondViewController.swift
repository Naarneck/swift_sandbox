//
//  SecondViewController.swift
//  day05
//
//  Created by Ivan Zelenskyi on 10/8/18.
//  Copyright © 2018 Ivan Zelenskyi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MyPointAnnotation : MKPointAnnotation {
    var pinTintColor: UIColor?
}

class SecondViewController: UIViewController ,CLLocationManagerDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    
    var pins  : [MapPin] = []
    var pin : MapPin?
    var userActive : Bool = false
    let location = CLLocationManager()
    
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            mapView.mapType = .standard
        }
    
    }
    @IBAction func navTouser(_ sender: UIButton) {
        print("show user location")
        userActive = true
    }
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location = locations[0]
        let locUser = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let regionToZoom = MKCoordinateRegionMakeWithDistance(locUser, 200, 200)
    if (userActive){
        self.mapView.setRegion(regionToZoom, animated: true)
        self.mapView.showsUserLocation = true
    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.location.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            print("location request")
            location.delegate = self
            location.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            location.startUpdatingLocation()
        }
        pins.append(MapPin(title : "42", subtitle: "Le baguette", coordinate : CLLocationCoordinate2D(latitude: 48.8966838, longitude : 2.3183755)))
        pins.append(MapPin(title : "UNIT", subtitle: "Borsch", coordinate : CLLocationCoordinate2D(latitude: 50.468999 , longitude : 30.462243)))
        pins.append(MapPin(title : "42 Fremont", subtitle: "The HotDog", coordinate : CLLocationCoordinate2D(latitude: 37.548660 , longitude : -122.059346)))
        print(pins)
        pin = pins.first
        for map in pins{
            print(map)
            if (map.title == "UNIT"){
                map.pinTintColor = .green
            }
            mapView.addAnnotation(map)
        }
        let regionToZoom = MKCoordinateRegionMakeWithDistance((pin?.coordinate)!, 200, 200)
        mapView.setRegion(regionToZoom, animated: true)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        userActive = false
        let regionToZoom = MKCoordinateRegionMakeWithDistance((pin?.coordinate)!, 200, 200)
        mapView.setRegion(regionToZoom, animated: true)
    }
    
}

