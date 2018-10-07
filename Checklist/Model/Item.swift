//
//  Item.swift
//  Checklist
//
//  Created by Anne Kristine on 07/10/2018.
//  Copyright © 2018 Thomas Østlyng. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
	@objc dynamic var title: String = ""
	@objc dynamic var done: Bool = false
	@objc dynamic var dateCreated: Date?
	var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
