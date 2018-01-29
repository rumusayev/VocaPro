//
//  Word.swift
//  VocaPro
//
//  Created by Ruslan on 1/22/18.
//  Copyright © 2018 Ruslan Musayev. All rights reserved.
//

import Foundation
import RealmSwift

class Word: Object {
    @objc dynamic var id : Int = 0
    @objc dynamic var word : String = ""
    @objc dynamic var translation : String = ""
    @objc dynamic var transcription : String = ""
    @objc dynamic var example : String = ""
    @objc dynamic var dateCreated : Date?
    var parentSheet = LinkingObjects(fromType: Sheet.self, property: "words")
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(Word.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}
