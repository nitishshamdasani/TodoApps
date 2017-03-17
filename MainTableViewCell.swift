//
//  MainTableViewCell.swift
//  TodoApp
//
//  Created by Nitish on 17/03/17.
//  Copyright © 2017 TodoApp. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var removeBtn: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblPriority: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
