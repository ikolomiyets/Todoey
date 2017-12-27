//
//  Item.swift
//  Todoey
//
//  Created by Igor Kolomiyets on 26/12/2017.
//  Copyright © 2017 IKtech. All rights reserved.
//

import Foundation

class Item : Codable {
    var title = ""
    var done : Bool = false
    init() {
        
    }
    
    init(title : String, isChecked : Bool) {
        self.title = title
        self.done = isChecked
    }
    
    init(_ title: String) {
        self.title = title
        self.done = false
    }
}

