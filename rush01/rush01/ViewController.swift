//
//  ViewController.swift
//  rush01
//
//  Created by Ivan Zelenskyi on 10/13/18.
//  Copyright © 2018 Ivan Zelenskyi. All rights reserved.
//

import UIKit
import Mapbox
import MapboxDirections
import MapboxNavigation
import MapboxCoreNavigation
import MapboxGeocoder

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButtonOutlet: UIButton!
    @IBOutlet weak var searchDestField: UITextField!
    @IBOutlet weak var switchLoc: UISwitch!
    
    let location = CLLocationManager()
    var mapView : NavigationMapView!
    let geocoder = Geocoder(accessToken: "sk.eyJ1IjoibmFhcm5lY2siLCJhIjoiY2puN2c3ZXRwMDVoYzNxbG1oZWVjamcwdiJ9.j6tMNP59PGGzVBvjKJSQJg")
    var userActive : Bool = false
    
    var userLocation :CLLocationCoordinate2D!
    var locStart :CLLocationCoordinate2D!
    var locFinish :CLLocationCoordinate2D!
    var locTemp : CLLocationCoordinate2D!

    var directionRoute : Route?
    
    override func viewDidLoad() {
        
        self.location.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            print("location request")
            location.delegate = self
            location.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            location.startUpdatingLocation()
        }
        
        super.viewDidLoad()
        mapView = NavigationMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)
        view.sendSubview(toBack: mapView)
        searchButtonOutlet.backgroundColor = UIColor.clear
//        searchField.bringSubview(toFront: self.view)
//        searchButtonOutlet.bringSubview(toFront: self.view)
    }

    func calcRoute(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D, completion : @escaping (Route?, Error?) -> Void){

        let start = Waypoint(coordinate: from, coordinateAccuracy : -1, name : "Start")
        let finish = Waypoint(coordinate: to, coordinateAccuracy : -1, name : "Finish")
        let options = NavigationRouteOptions(waypoints: [start, finish], profileIdentifier: .automobileAvoidingTraffic)
        _ = Directions.shared.calculate(options, completionHandler: { (waypointes, routes, error) in
            if error != nil{
                print("so bad")
                //
                let alert = UIAlertController(title: "Alert", message: "Sorry, can't build the route", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                    action in
                    switch action.style{
                    case .default:
                        print("default")
                    case .cancel:
                        print("cancel")
                    case .destructive:
                        print("destructive")
                    }
                }))
                self.present(alert, animated: true, completion: nil)
                return
            }
            self.directionRoute = routes?.first
            self.drawRoute(route: self.directionRoute!)
            let coordFrame = MGLCoordinateBounds(sw: to, ne: from)
            let insets = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
            let camera = self.mapView.cameraThatFitsCoordinateBounds(coordFrame, edgePadding: insets)
            self.mapView.setCamera(camera, animated: true)
        })
    }
    
    func drawRoute(route : Route){
        if  route.coordinateCount <= 0 { return
        }
        var routeCoords = route.coordinates!
        let polyline = MGLPolylineFeature(coordinates : &routeCoords, count : UInt(route.coordinates!.count))
        
        if let source = mapView.style?.source(withIdentifier: "route-source") as? MGLShapeSource{
            source.shape = polyline
        } else{
            let source = MGLShapeSource(identifier: "route-source", features : [polyline], options : nil)
            let style = MGLLineStyleLayer(identifier: "route-style", source: source)
            style.lineColor = MGLStyleValue(rawValue : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
            style.lineWidth = MGLStyleValue(rawValue : 3.0)
            
            mapView.style?.addSource(source)
            mapView.style?.addLayer(style)
        }
        
    }
    
    
    func findPlace(place : String, completion : @escaping(_ success : Bool) -> Void){
        let options = ForwardGeocodeOptions(query: place)
        let _ = geocoder.geocode(options) { (placemarks, attribution, error) in
            guard let placemark = placemarks?.first else {
                return
            }
            print(placemark.name)
            print(placemark.qualifiedName!)
            let coordinate = placemark.location?.coordinate
            print("\(String(describing: coordinate?.latitude)), \(String(describing: coordinate?.longitude))")
//            let camera = MGLMapCamera(lookingAtCenter: (placemark.location?.coordinate)!, fromDistance: 4000, pitch: 0, heading: 0)
//            self.mapView.setCamera(camera, animated: true)
            self.locTemp = coordinate!
            completion(true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        self.userLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let camera = MGLMapCamera(lookingAtCenter: self.userLocation, fromDistance: 1000, pitch: 0, heading: 0)
//        let regionToZoom = MKCoordinateRegionMakeWithDistance(locUser, 200, 200)
        if (userActive){
            self.mapView.setCamera(camera, animated: true)
            self.mapView.showsUserLocation = true
        }
    }
    
    ///
    
    @IBAction func swwitch(_ sender: UISwitch) {
        if sender.isOn == true{
            self.locStart = self.userLocation
            searchField.isEnabled = false
            searchButtonOutlet.isEnabled = false
        } else{
            searchField.isEnabled = true
            searchButtonOutlet.isEnabled = true
        }
    }
    
    @IBAction func showUser(_ sender: Any) {
        if !userActive{
            self.userActive = true
        } else{
            self.userActive = false
        }
    }
    
    @IBAction func mapStyle(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.styleURL = MGLStyle.lightStyleURL()
        case 1:
            mapView.styleURL = MGLStyle.satelliteStreetsStyleURL()
        case 2:
            mapView.styleURL = MGLStyle.darkStyleURL()
        default:
            mapView.styleURL = MGLStyle.lightStyleURL()
        }
    }
    
    @IBAction func searchButton(_ sender: Any) {
        print("GO Button Pressed")
        self.userActive = false
        findPlace(place : self.searchField.text!){
            (success) -> Void in
            if success{
                print("go")
                print(self.locTemp)
                let camera = MGLMapCamera(lookingAtCenter: self.locTemp, fromDistance: 4000, pitch: 0, heading: 0)
                self.mapView.setCamera(camera, animated: true)
            } else{
                print("no")
            }
        }
    }
    
    @IBAction func goRoute(_ sender: Any) {
        self.userActive = false

        self.findPlace(place : self.searchField.text!){
            (success) -> Void in
            if success{
                self.locStart = self.locTemp
                print("locs1:")
//                print(self.locFinish)
//                print(self.locStart)
                self.findPlace(place : self.searchDestField.text!){
                    (success) -> Void in
                    if success{
                        self.locFinish = self.locTemp
                        print("locs2:")
                        //                print(self.locFinish)
                        //                print(self.locStart)
                        if self.switchLoc.isOn{
                            if self.locFinish != nil {
                                self.calcRoute(from: self.userLocation, to: self.locFinish){
                                    (route, error) in
                                    if error != nil{
                                        print("so bad")
                                    }
                                }
                            }
                        } else {
                            if self.locFinish != nil && self.locStart != nil{
                                self.calcRoute(from: self.locStart, to: self.locFinish){
                                    (route, error) in
                                    if error != nil{
                                        print("so bad")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        //locations check for nil
//        if self.locFinish == nil{
//            let alert = UIAlertController(title: "Alert", message: "Set destination point first", preferredStyle: UIAlertControllerStyle.alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
//                action in
//                switch action.style{
//                case .default:
//                    print("default")
//                    return
//                case .cancel:
//                    print("cancel")
//                    return
//                case .destructive:
//                    print("destructive")
//                    return
//                }
//            }))
//            self.present(alert, animated: true, completion: nil)
//        } else if self.locStart == nil{
//            let alert = UIAlertController(title: "Alert", message: "Set start point", preferredStyle: UIAlertControllerStyle.alert)
//            alert.addAction(UIAlertAction(title: "Use my location", style: .default, handler: {
//                action in
//                switch action.style{
//                case .default:
//                    print("default")
//                    self.locStart = self.userLocation
//                case .cancel:
//                    print("cancel")
//                    return
//                case .destructive:
//                    print("destructive")
//                    return
//                }
//            }))
//            self.present(alert, animated: true, completion: nil)
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}




