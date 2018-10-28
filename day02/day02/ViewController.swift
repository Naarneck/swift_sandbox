//
//  ViewController.swift
//  day02
//
//  Created by Ivan Zelenskyi on 10/3/18.
//  Copyright © 2018 Ivan Zelenskyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var items : [Item] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var descLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initList()
        
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 100
//        tableView.estimatedRowHeight = 100
    
    }
  
    @IBAction func addButton(_ sender: Any) {
        performSegue(withIdentifier: "addInfo", sender: sender)
    }
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
    }
    
    func initList(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        let item1 = Item(date : formatter.date(from: "2018/12/01 22:42")!, name : "Mr Baguette", desc : "death while TIG")
        let item2 = Item(date : formatter.date(from: "2018/12/02 12:42")!, name : "Mr Fromage", desc : "no reason")
        let item3 = Item(date : formatter.date(from: "2018/12/03 12:21")!, name : "Mr Crab", desc : "why not?")
        items.append(item1)
        items.append(item2)
        items.append(item3)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell") as! NoteCell
        
        cell.setNote(item: item)
        return cell
    }
}

extension ViewController: infoAddDelegate {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addInfo"){
            let addVC : AddViewController = segue.destination as! AddViewController
                        addVC.infoDelegate = self
        }
    }
    
    func donePressed(name : String, date : Date, desc : String) {
        let item = Item(date : date, name : name, desc : desc)
        if (name.count > 1){
            items.append(item)
            print(items)
            self.tableView.reloadData()
        } else{
            print("name missing!")
        }
    }
}
