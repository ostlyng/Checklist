//
//  ChecklistController.swift
//  Checklist
//
//  Created by Thomas Østlyng on 07/10/2018.
//  Copyright © 2018 Thomas Østlyng. All rights reserved.
//

import UIKit

class ChecklistController: UITableViewController {
	
	
	var itemArray = [Item]()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let newItem = Item()
		newItem.title = "Buy eggs"
		itemArray.append(newItem)
		
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	
	//MARK - Tableview Datasource Methods
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistCell", for: indexPath)
		
		let item = itemArray[indexPath.row]
	
		cell.textLabel?.text = item.title
		
		cell.accessoryType = item.done ? .checkmark : .none
		
		return cell
	}
	
	
	//MARK - Tableview Delegate Methods
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		itemArray[indexPath.row].done = !itemArray[indexPath.row].done
		
		tableView.reloadData()

		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	
	//MARK - Add New Items
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		
		var textField = UITextField()
		
		let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
		
		let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
			
			let newItem = Item()
			newItem.title = textField.text!
			
			
			self.itemArray.append(newItem)
			
			self.tableView.reloadData()
		}
		
		alert.addTextField { (alertTextfield) in
			alertTextfield.placeholder = "Create new item"
			textField = alertTextfield
		}
		
		alert.addAction(action)
		
		present(alert, animated: true, completion: nil)
	}
	
	


}

