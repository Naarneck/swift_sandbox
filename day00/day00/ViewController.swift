//
//  ViewController.swift
//  day00
//
//  Created by Ivan Zelenskyi on 10/1/18.
//  Copyright © 2018 Ivan Zelenskyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var num1:Int? = 0
    var num2:Int? = 0
    var text = ""
    var operation = "0"
    
    @IBOutlet weak var numText: UILabel!
    @IBOutlet weak var labelHello: UILabel!
    
    func switchNum(oper :String){
        num1 = Int(numText.text ?? "")
        numText.text = "0"
        operation = oper
    }
    func cleanZero()
    {
        if (numText.text ?? "").hasPrefix("0"){
            numText.text = String((numText.text ?? "").dropFirst())
        }
    }
    @IBAction func clickButton(_ sender: UIButton) {
        print("Hello World!")

        if(labelHello.text == "Hello world!"){
            labelHello.text = "Goodbye world!"
        } else {
            labelHello.text = "Hello world!"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonOne(_ sender: Any) {
        cleanZero()
        print("1")
        if (numText.text!.count < 10){
            numText.text = (numText.text ?? "") + "1"
        }
    }

    @IBAction func buttonTwo(_ sender: Any) {
        cleanZero()
        print("2")
        if (numText.text!.count < 10){
            numText.text = (numText.text ?? "") + "2"
        }
    }
    
    @IBAction func buttonThree(_ sender: Any) {
        cleanZero()
        print("3")
        if (numText.text!.count < 10){
            numText.text = (numText.text ?? "") + "3"
        }
    }
    
    @IBAction func buttonFour(_ sender: Any) {
        cleanZero()
        print("4")
        if (numText.text!.count < 10){
        numText.text = (numText.text ?? "") + "4"
    
        }
    }
    
    @IBAction func buttonFive(_ sender: Any) {
        cleanZero()
        print("5")
        if (numText.text!.count < 10){
            numText.text = (numText.text ?? "") + "5"
        }
    }
    
    @IBAction func buttonSix(_ sender: Any) {
        cleanZero()
        print("6")
        if (numText.text!.count < 10){
            numText.text = (numText.text ?? "") + "6"
        }
    }
    
    @IBAction func buttonSeven(_ sender: Any) {
        cleanZero()
        print("7")
        if (numText.text!.count < 10){
            numText.text = (numText.text ?? "") + "7"
        }
    }
    
    @IBAction func buttonEight(_ sender: Any) {
        cleanZero()
        print("8")
        if (numText.text!.count < 10){
            numText.text = (numText.text ?? "") + "8"
        }
    }
    @IBAction func buttonNine(_ sender: Any) {
        cleanZero()
        print("9")
        if (numText.text!.count < 10){
            numText.text = (numText.text ?? "") + "9"
        }
    }
    
    @IBAction func buttonZero(_ sender: Any) {
        cleanZero()
        print("0")
        if (numText.text!.count < 10){
            numText.text = (numText.text ?? "") + "0"
        }
    }
    
    @IBAction func buttonAC(_ sender: Any) {
        print("Clear")
        numText.text = "0"
        num1 = 0
        num2 = 0
    }
    
    @IBAction func buttonNeg(_ sender: Any) {
        print("Neg")
        if !(numText.text ?? "").hasPrefix("-"){
            numText.text = "-" + (numText.text ?? "")
        } else {
            numText.text = String((numText.text ?? "").dropFirst())
        }
    }
    
    @IBAction func buttonPlus(_ sender: Any) {
        switchNum(oper: "+")
        
        print("+")
    }
    
    @IBAction func buttonMinus(_ sender: Any) {
        switchNum(oper: "-")
        print("-")
    }
    
    @IBAction func buttonMult(_ sender: Any) {
        switchNum(oper: "*")
        print("*")
    }
    
    @IBAction func buttonDiv(_ sender: Any) {
        switchNum(oper: "/")
        print("/")
    }
    
    @IBAction func buttonEqual(_ sender: Any) {
        num2 = Int(numText.text ?? "")
        switch operation {
        case "-":
            let res:Int = num1! &- num2!
            numText.text = String(res)
        case "+":
            let res:Int = num1! &+ num2!
            numText.text = String(res)
        case "*":
            let res:Int = num1! &* num2!
            numText.text = String(res)
        case "/":
            if num2 != 0{
                numText.text = String(num1! / num2!)
            } else {
                numText.text = "Error"
            }
        default:
            numText.text = "0"
        }
        print("=")
    }
}

