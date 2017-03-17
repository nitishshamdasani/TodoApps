

import UIKit

class PickerView: UIView {

    @IBOutlet weak var pickerSuperView: UIView!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var pickerDate: UIDatePicker!
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)
        
//        pickerSuperView.layer.cornerRadius = 4.0
//        btnDone.layer.cornerRadius = 4.0
//        btnCancel.layer.cornerRadius = 4.0
    }
    
    required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
    }
}
