//
//  TextTableViewCell.swift
//  TodoApp
//
//  Created by Nitish on 16/03/17.
//  Copyright © 2017 TodoApp. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell,UITextFieldDelegate {
    
    
    @IBOutlet weak var txtFld: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //MARK: TextField Delagtes
    func textFieldDidBeginEditing(_ textField: UITextField) {
      
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.contentView.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 0 {
            self.contentView.endEditing(true)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 1{
            NotificationCenter.default.post(name: Notification.Name("pickerViewShow"), object: nil)
            return false
        }else{
            return true
        }
    }

}
