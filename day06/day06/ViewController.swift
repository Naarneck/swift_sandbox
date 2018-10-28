//
//  ViewController.swift
//  day06
//
//  Created by Ivan Zelenskyi on 10/9/18.
//  Copyright © 2018 Ivan Zelenskyi. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    var animator: UIDynamicAnimator?
    var gravity : UIGravityBehavior?
    var elasticity : UIDynamicItemBehavior?
    var collision : UICollisionBehavior?
    var motion: CMMotionManager?
    
    var figure : UIView?
    var figures : [UIView] = [UIView()]
    var counter = 0
    let colors : [UIColor] = [
        UIColor.yellow,
        UIColor.black,
        UIColor.cyan,
        UIColor.orange,
        UIColor.green]
    
    func getFigure(x: CGFloat, y : CGFloat) -> UIView{
        let rand = Int(arc4random_uniform(UInt32(colors.count)))
        if (rand % 2 == 0)
        {
            let square = UIView(frame: CGRect(x : x , y : y, width : 50, height: 50))
            square.backgroundColor = colors[rand]
            return square
        } else {
            let circle = UIView(frame: CGRect(x : x , y : y, width : 50, height: 50))
            circle.layer.cornerRadius = circle.frame.height / 2
            circle.clipsToBounds = true
            circle.backgroundColor = colors[rand]
            circle.clipsToBounds = true
            return circle
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(touchGesture))
        view.addGestureRecognizer(gesture)
        
        animator = UIDynamicAnimator(referenceView : self.view)
        motion = CMMotionManager()
        
        motion?.accelerometerUpdateInterval = 0.2
        
        self.gravity = UIGravityBehavior()
        self.gravity?.angle = 3.14 / 2
        self.elasticity = UIDynamicItemBehavior()
        self.collision = UICollisionBehavior()
        self.collision?.translatesReferenceBoundsIntoBoundary = true
        self.elasticity?.elasticity = 0.7
        animator?.addBehavior(self.gravity!)
        animator?.addBehavior(self.collision!)
        animator?.addBehavior(self.elasticity!)

        motion?.startAccelerometerUpdates(to: OperationQueue.current!, withHandler:{
            (data, error) in
            if let d = data{
                if (d.acceleration.y > 0){
                    self.gravity?.angle = -3.14 / 2
                } else{
                    self.gravity?.angle = 3.14 / 2
                }
            }
        })
    }
    
    @IBAction func touchGesture(_ sender: UITapGestureRecognizer) {
        if (figures.count <= 110){
            let point = sender.location(in: self.view)
            let figure = getFigure(x: point.x, y: point.y)
            figures.append(figure)
            self.view.addSubview(figure)
            self.gravity?.addItem(figure)
            self.collision?.addItem(figure)
            self.elasticity?.addItem(figure)
//            counter += 1
        } else {
            figures.first?.removeFromSuperview()
            self.gravity?.removeItem(figures.first!)
            self.collision?.removeItem(figures.first!)
            self.elasticity?.removeItem(figures.first!)
            figures.remove(at: 0)
        }
        print(figures.count)
    }
    
//    @objc func panGesture(gesture: UIPanGestureRecognizer)
//    {
//        switch gesture.state{
//            case .began:
//                let rect = CGRect(x : 0, y : 0, width : 50, height: 50)
//                greenRect = UIView(frame : rect)
//                greenRect?.backgroundColor = UIColor.cyan
//                self.view.addSubview(greenRect!)
//                print("begin")
//            case .cancelled:
//                print("cancelled")
//            case .changed:
//                print("changed")
//            case .ended:
//                print("ended")
//            case .failed:
//                print("failed")
//            case .possible:
//                print("possible")
//        }
//    }
    
    
}

