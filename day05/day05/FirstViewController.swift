//
//  FirstViewController.swift
//  day05
//
//  Created by Ivan Zelenskyi on 10/8/18.
//  Copyright © 2018 Ivan Zelenskyi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class FirstViewController: UIViewController{


    
    var pins : [MapPin] = []
    @IBOutlet weak var tableView: UITableView!
    
    func initPlaces()
    {
        pins.append(MapPin(title : "42", subtitle: "Le baguette", coordinate : CLLocationCoordinate2D(latitude: 48.89668380000001 , longitude : 2.318375500000002)))
        pins.append(MapPin(title : "UNIT", subtitle: "Borsch", coordinate : CLLocationCoordinate2D(latitude: 50.468999 , longitude : 30.462243)))
        pins.append(MapPin(title : "42 Fremont", subtitle: "The HotDog", coordinate : CLLocationCoordinate2D(latitude: 37.548660 , longitude : -122.059346)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPlaces()
        

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension FirstViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pin = pins[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! TableViewCell
        cell.placeName.text = pin.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secVC = self.tabBarController?.viewControllers![1] as! SecondViewController
        secVC.pin = pins[indexPath.row]
        print("trying to segue")
        self.tabBarController?.selectedIndex = 1
//        destinationVC.performSegue(withIdentifier: "ToMap", sender: nil)
    }
}
