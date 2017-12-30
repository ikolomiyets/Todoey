//
//  Item.swift
//  Todoey
//
//  Created by Igor Kolomiyets on 29/12/2017.
//  Copyright © 2017 IKtech. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date = Date()
    var parentCategory : LinkingObjects = LinkingObjects(fromType: Category.self, property: "items")
}
