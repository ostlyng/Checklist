//
//  ChecklistController.swift
//  Checklist
//
//  Created by Anne Kristine on 07/10/2018.
//  Copyright © 2018 Thomas Østlyng. All rights reserved.
//

import UIKit

class ChecklistController: UITableViewController {
	
	
	let itemArray = ["Buy Milk", "Buy bread", "Buy toothpaste"]

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	
	//MARK - Tableview Datasource Methods
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistCell", for: indexPath)
		
		cell.textLabel?.text = itemArray[indexPath.row]
		
		return cell
	}
	
	
	//MARK - Tableview Delegate Methods
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		print(itemArray[indexPath.row])
		
		if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
			tableView.cellForRow(at: indexPath)?.accessoryType = .none
		} else {
			tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
		}

		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	


}

