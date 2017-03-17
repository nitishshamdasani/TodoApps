//
//  FirstViewController.swift
//  TodoApp
//
//  Created by Nitish on 16/03/17.
//  Copyright © 2017 TodoApp. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift
class FirstViewController: RootViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tblView: UITableView!
    var arrBrandDetails : Results<TodoList>!
    var searchResults = Array<TodoList>()
    let searchController = UISearchController(searchResultsController: nil)
    var arr = Array<TodoList>()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          tblView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableViewCell")
            searchController.searchResultsUpdater = self
            searchController.searchBar.delegate = self
            definesPresentationContext = true
            searchController.dimsBackgroundDuringPresentation = false
            tblView.tableHeaderView = searchController.searchBar
    }


    
    override func viewWillAppear(_ animated: Bool) {
        let uiRealm = try! Realm()
        arrBrandDetails = uiRealm.objects(TodoList.self)
        arr = Array(arrBrandDetails)
        tblView.reloadData()
        print(arr)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    /*************************************************************************************************/
    
    //MARK: - TableView Delegate & DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return searchResults.count
        }
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as! MainTableViewCell
        if searchController.isActive && searchController.searchBar.text != "" {
            cell.lblContent.text = searchResults[indexPath.row].todoTask
            cell.lblDate.text = searchResults[indexPath.row].date
            cell.removeBtn.tag = searchResults[indexPath.row].id
        }else{
            cell.lblContent.text = arr[indexPath.row].todoTask
            cell.lblDate.text = arr[indexPath.row].date
            cell.removeBtn.tag = arr[indexPath.row].id
        }
        cell.removeBtn.addTarget(self, action: #selector(FirstViewController.deleteContent), for: .touchUpInside)
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 87.0
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    
    
    
    
    
    /**********************************************************************/
    //MARK: FILTER SEARCHED DATA
    func filterContentForSearchText(_ searchText: String) {
        searchResults = arr.filter({( todoList : TodoList) -> Bool in
            
            return todoList.todoTask!.lowercased().contains(searchText.lowercased())
        })

        tblView.reloadData()
    }


    
    
    
    /**********************************************************************/
    //MARK: ADD ELEMENTS TO DATABASE - PUSH TO NEXT CONTROLLER
    @IBAction func addBtn(_ sender: Any) {
        let obj = InsertionViewController(nibName: "InsertionViewController", bundle: nil)
        self.navigationController?.pushViewController(obj, animated: true)
        
    }
    
    
    
    
    
    
    /**********************************************************************/
    //MARK: REMOVE DATA - DELETION
    func deleteContent(sender:UIButton){
        print(sender.tag)
        
        let uiRealm = try! Realm()
        var result : Results<TodoList>!
        result = uiRealm.objects(TodoList.self)
        
        try! uiRealm.write({ () -> Void in
            uiRealm.delete(result.filter("id == \(sender.tag)"))
        })
        arr.removeAll()
        arrBrandDetails = uiRealm.objects(TodoList.self)
        arr = Array(arrBrandDetails)
        self.filterContentForSearchText(searchController.searchBar.text!)
        tblView.reloadData()
    }
    
    
    
    /***************************************************/
    
    //MARK: ASCENDING AND DESCENDING ACCORDING TO DATE
    @IBAction func btnDateAscending(_ sender: UIButton) {
        
        arr.sort(by: {$0.date?.compare($1.date!) == .orderedAscending})
        tblView.reloadData()
    }
    
    @IBAction func btnDateDecending(_ sender: UIButton) {
        arr.sort(by: {$0.date?.compare($1.date!) == .orderedDescending})
        tblView.reloadData()

    }
    
    

}
extension FirstViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
}

extension FirstViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
