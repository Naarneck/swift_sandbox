//
//  ViewController.swift
//  day03
//
//  Created by Ivan Zelenskyi on 10/4/18.
//  Copyright © 2018 Ivan Zelenskyi. All rights reserved.
//

import UIKit

let qos = DispatchQoS.background.qosClass
let queue = DispatchQueue.global(qos : qos)


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

    var images = [UIImage]()
    var data = [Data]()
    @IBOutlet weak var imageCollection: UICollectionView!

    let urls : [URL] = [URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/45025340661_7b9f8f9402_k.jpg")!,
                        URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/iss056e162811.jpg")!,
                        URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/iss056e102671_0.jpg")!, // broke url
                        URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/iss056e006994_lrg.jpg")!
    ]

    

    func loadImages(){
        for each in urls{
            if let dt = try? Data(contentsOf: each){
                data.append(dt)
            } else {
                let url = URL.init(fileURLWithPath: "/Users/izelensk/Unit/Swift/day03/day03/day03/Assets.xcassets/ph.imageset/placeholder-image.png", isDirectory: false)
                data.append(try! Data(contentsOf: url))
                showAlert()
            }
//        data.append(try! Data(contentsOf: urls[1]))
//        data.append(try! Data(contentsOf: urls[2]))
//        data.append(try! Data(contentsOf: urls[3]))
        }
//        var data = [Data]()
//        data.append(try! Data(contentsOf: urls[]!))
//        data.append(try! Data(contentsOf: url2!))
//        data.append(try! Data(contentsOf: url3!))
//        data.append(try! Data(contentsOf: url4!))
        
        images.append(UIImage(named: "ph")!)
        images.append(UIImage(named: "ph")!)
        images.append(UIImage(named: "ph")!)
        images.append(UIImage(named: "ph")!)
        imageCollection.reloadData()
//        queue.async {
//            self.images[0] = UIImage(data: data[0])!
//            self.images[1] = UIImage(data: data[1])!
//            self.images[2] = UIImage(data: data[2])!
//            self.images[3] = UIImage(data: data[3])!
//        }
        DispatchQueue.main.async {
            self.imageCollection.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImages()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func showAlert()
    {
        let alert = UIAlertController(title: "Error loading img", message: "very bad.", preferredStyle: UIAlertControllerStyle.alert)
        let okAlert = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {(ACTION) in print("alert pressed")}
        alert.addAction(okAlert)
        self.present(alert, animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ToImages", sender: nil)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! CollectionViewCell
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        cell.activity.startAnimating()
        let image = images[indexPath.row]
        cell.imageView.image = image
        print(indexPath.row)
        queue.async {
            if let image = UIImage(data: self.data[indexPath.row]){
                self.images[indexPath.row] = image
//                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    cell.activity.stopAnimating()
                    cell.activity.isHidden = true
//                }
            }else {
                self.showAlert()
            }
            print("loading. . . ..  ")
        }
        return cell
    }
    
}

