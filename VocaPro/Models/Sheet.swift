//
//  Sheet.swift
//  VocaPro
//
//  Created by Ruslan on 1/22/18.
//  Copyright © 2018 Ruslan Musayev. All rights reserved.
//

import Foundation
import RealmSwift

class Sheet: Object {
    @objc dynamic var id : Int = 0
    @objc dynamic var sheetName : String = ""
    @objc dynamic var timeFrame : Double = 0.0
    @objc dynamic var sequence : Double = 0.0
    var words = List<Word>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(Sheet.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}
