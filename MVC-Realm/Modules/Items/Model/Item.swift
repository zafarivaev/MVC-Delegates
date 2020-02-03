//
//  Item.swift
//  MVC-Realm
//
//  Created by Zafar on 1/28/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import RealmSwift

class Item: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var id = UUID().uuidString
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
