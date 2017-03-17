//
//  InsertionViewController.swift
//  TodoApp
//
//  Created by Nitish on 16/03/17.
//  Copyright © 2017 TodoApp. All rights reserved.
//

import UIKit
import RealmSwift
class InsertionViewController: RootViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tblInsertion: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        tblInsertion.register(UINib(nibName: "TextTableViewCell", bundle: nil), forCellReuseIdentifier: "TextTableViewCell")
        tblInsertion.register(UINib(nibName: "PriorityTableViewCell", bundle: nil), forCellReuseIdentifier: "PriorityTableViewCell")
        tblInsertion.register(UINib(nibName: "AddButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "AddButtonTableViewCell")
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.pickerViewShow),
            name: NSNotification.Name(rawValue: "pickerViewShow"),
            object: nil)
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }

    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    /**********************************************************************/
    // MARK: - TableViewDelegate & DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextTableViewCell") as! TextTableViewCell
            cell.txtFld.tag = 0
            return cell
        
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextTableViewCell") as! TextTableViewCell
            cell.txtFld.tag = 1
            cell.txtFld.placeholder = "Date"
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddButtonTableViewCell") as! AddButtonTableViewCell
            cell.btnAdd.addTarget(self, action: #selector(InsertionViewController.addToDatabase), for: .touchUpInside)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    
    
    
    
    
    /**********************************************************************/
    //MARK: - Add to REALM Database
    
    func addToDatabase(){
        let cell = tblInsertion.cellForRow(at: IndexPath(row: 0, section: 0)) as! TextTableViewCell
        let cell1 = tblInsertion.cellForRow(at: IndexPath(row: 1, section: 0)) as! TextTableViewCell
        self.view.endEditing(true)
        let objTodoList = TodoList()
        let uiRealm = try! Realm()
        if cell1.txtFld.text != "" && cell.txtFld.text != "" {
            objTodoList.date = cell1.txtFld.text
            objTodoList.todoTask = cell.txtFld.text
            objTodoList.id = self.incrementaID()
        try! uiRealm.write { () -> Void in
            uiRealm.add(objTodoList);
        }
        self.popController()
        }else{
            let alert = UIAlertController(title: "INVALID", message: "Fields cannot be empty!!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    
    
    /**********************************************************************/
    //MARK: INCREMENT PRIMARY KEY
    func incrementaID() -> Int{
        let realm = try! Realm()
        let RetNext: NSArray = Array(realm.objects(TodoList.self).sorted(byKeyPath: "id")) as NSArray
        let last = RetNext.lastObject
        if RetNext.count > 0 {
            let valor = (last as AnyObject).value(forKey: "id") as? Int
            return valor! + 1
        } else {
            return 1
        }
    }
    
    
    
    
    
    
    /**********************************************************************/
    //MARK: PopViewController
    
    func popController(){
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    
    /*********************************************************************************************/
    // MARK: - DatePickerPopUp
    func pickerViewShow(){
        self.view.endEditing(true)
        let objPickerOperatorView = Bundle.main.loadNibNamed("PickerView", owner: self, options: nil)!.first as? PickerView
        objPickerOperatorView?.pickerDate.minimumDate = NSDate() as Date
        objPickerOperatorView?.frame = self.view.window!.frame
        self.view.addSubview(objPickerOperatorView!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        objPickerOperatorView?.pickerDate.addTarget(self, action: #selector(InsertionViewController.valueOfDateChanged(sender:)), for: .valueChanged)
        let cell1 = tblInsertion.cellForRow(at: IndexPath(row: 1, section: 0)) as! TextTableViewCell
        cell1.txtFld.text = dateFormatter.string(from: (objPickerOperatorView?.pickerDate.date)!)
        tblInsertion.reloadData()
        objPickerOperatorView!.btnDone.addTarget(self, action: #selector(btnDoneEvent), for: .touchUpInside)
        objPickerOperatorView!.btnCancel.addTarget(self, action: #selector(btnCancelEvent), for: .touchUpInside)
    }
    
    func btnDoneEvent(){
        for view in (view.subviews){
            if view.isKind(of: PickerView.self){
                view.removeFromSuperview()
            }
        }
    }
    
    func btnCancelEvent(){
        for view in (view.subviews){
            if view.isKind(of: PickerView.self){
                view.removeFromSuperview()
            }
        }
        let cell1 = tblInsertion.cellForRow(at: IndexPath(row: 1, section: 0)) as! TextTableViewCell
        cell1.txtFld.text = ""
    }
    
    func valueOfDateChanged(sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let cell1 = tblInsertion.cellForRow(at: IndexPath(row: 1, section: 0)) as! TextTableViewCell
        cell1.txtFld.text = dateFormatter.string(from: sender.date)
        tblInsertion.reloadData()
    }
    
    
  
}
