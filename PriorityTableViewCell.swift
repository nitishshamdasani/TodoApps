//
//  PriorityTableViewCell.swift
//  TodoApp
//
//  Created by Nitish on 16/03/17.
//  Copyright © 2017 TodoApp. All rights reserved.
//

import UIKit
enum Priority:NSNumber {
    case high = 1
    case medium = 2
    case low = 3
    
}
class PriorityTableViewCell: UITableViewCell {
    @IBOutlet weak var btnHigh: UIButton!

    @IBOutlet weak var btnMedium: UIButton!
    
    @IBOutlet weak var btnLow: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnMedium(_ sender: UIButton) {
        
    }
    @IBAction func btnHigh(_ sender: UIButton) {
    
    }
    
    @IBAction func btnLow(_ sender: UIButton) {
    }
}
