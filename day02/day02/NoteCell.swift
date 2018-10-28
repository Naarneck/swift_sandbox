//
//  NoteCell.swift
//  day02
//
//  Created by Ivan Zelenskyi on 10/3/18.
//  Copyright © 2018 Ivan Zelenskyi. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!

    func setNote(item : Item){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        dateLabel.text = formatter.string(from : item.date)
        nameLabel.text = item.name
        descLabel.text = item.desc
    }
}
