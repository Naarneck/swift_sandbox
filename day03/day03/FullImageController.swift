//
//  FullImageController.swift
//  day03
//
//  Created by Ivan Zelenskyi on 10/5/18.
//  Copyright © 2018 Ivan Zelenskyi. All rights reserved.
//

import UIKit

class FullImageController: UIViewController , UIScrollViewDelegate  {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var imageView : UIImageView?
    var image : UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
       
        scrollView.delegate = self
        image = UIImage(named : "im1.jpg")
        imageView = UIImageView(image: image)
        scrollView.addSubview(imageView!)
        scrollView.contentSize = (imageView?.frame.size)!
        scrollView.minimumZoomScale = self.scrollView.frame.size.width / (self.imageView?.frame.size.width)!;
        scrollView.maximumZoomScale = 10.0
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
 
    override func viewDidLayoutSubviews() {
        scrollView?.minimumZoomScale = scrollView.bounds.width / (self.imageView?.bounds.width)!
    }
}
