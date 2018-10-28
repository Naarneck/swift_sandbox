//
//  AddViewController.swift
//  day02
//
//  Created by Ivan Zelenskyi on 10/3/18.
//  Copyright © 2018 Ivan Zelenskyi. All rights reserved.
//

import UIKit

protocol infoAddDelegate{
    func donePressed(name : String, date : Date, desc : String)
}

class AddViewController: UIViewController {
    
    var infoDelegate : infoAddDelegate? = nil
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var addnameLabel: UITextField!
    @IBOutlet weak var addDateLabel: UIDatePicker!
    @IBOutlet weak var addDescLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.minimumDate = Date()
    }


    @IBAction func doneButton(_ sender: Any) {
        if (infoDelegate != nil){
            let nameA = addnameLabel.text!
            let dateA = addDateLabel.date
            let descA = addDescLabel.text!
            print(nameA)
            print(dateA)
            print(descA)
        infoDelegate!.donePressed(name : nameA,
                                 date : dateA,
                                  desc : descA)
        self.performSegue(withIdentifier: "unwindBack", sender: nil)
        }
    }
    
}
