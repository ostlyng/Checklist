//
//  Category.swift
//  Checklist
//
//  Created by Anne Kristine on 07/10/2018.
//  Copyright © 2018 Thomas Østlyng. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
	@objc dynamic var name: String = ""
	let items = List<Item>()
}
