//
//  Category.swift
//  Todoey
//
//  Created by Igor Kolomiyets on 29/12/2017.
//  Copyright © 2017 IKtech. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    @objc dynamic var bgColor : String = ""
    let items : List<Item> = List<Item>()
}
