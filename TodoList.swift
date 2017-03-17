//
//  TodoList.swift
//  TodoApp
//
//  Created by Nitish on 16/03/17.
//  Copyright © 2017 TodoApp. All rights reserved.
//

import UIKit
import RealmSwift
class TodoList: Object {
    dynamic var todoTask :String?
    dynamic var date :String?
    dynamic var id = 0
    override class func primaryKey() -> String? {
        return "id"
    }
}
