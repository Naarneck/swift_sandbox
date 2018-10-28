//
//  TableViewCell.swift
//  day05
//
//  Created by Ivan Zelenskyi on 10/8/18.
//  Copyright © 2018 Ivan Zelenskyi. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var placeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
