//
//  ChecklistController.swift
//  Checklist
//
//  Created by Thomas Østlyng on 07/10/2018.
//  Copyright © 2018 Thomas Østlyng. All rights reserved.
//

import UIKit
import RealmSwift

class ChecklistController: UITableViewController {
	
	
	var checklistItems: Results<Item>?
	let realm = try! Realm()
	
	var selectedCategory : Category? {
		didSet {
			loadItems()
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.separatorStyle = .none
	}
	
	override func viewWillAppear(_ animated: Bool) {
		
		title = selectedCategory?.name
		
	}
	
	
	
	
	//MARK: - Tableview Datasource Methods
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return checklistItems?.count ?? 1
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistCell", for: indexPath)
		
		if let item = checklistItems?[indexPath.row] {
			
			cell.textLabel?.text = item.title
			
			cell.accessoryType = item.done ? .checkmark : .none
			
		} else {
			cell.textLabel?.text = "No items added"
		}
	
		
		
		return cell
	}
	
	
	//MARK: - Tableview Delegate Methods
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		if let item = checklistItems?[indexPath.row] {
			do {
				try realm.write {
					item.done = !item.done
				}
			} catch {
				print("Error saving done status, \(error)")
			}
		}
		tableView.reloadData()
//		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	
	
	//MARK: - Add New Items
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		
		var textField = UITextField()
		
		let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
		
		let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
			
			if let currentCategory = self.selectedCategory {
				do {
					try self.realm.write {
						let newItem = Item()
						newItem.title = textField.text!
						newItem.dateCreated = Date()
						currentCategory.items.append(newItem)
					}
				} catch {
					print("Error saving new items, \(error)")
				}
			}
			self.tableView.reloadData()
		}
		
		alert.addTextField { (alertTextfield) in
			alertTextfield.placeholder = "Create new item"
			textField = alertTextfield
		}
		
		alert.addAction(action)
		
		present(alert, animated: true, completion: nil)
	}
	
	func loadItems() {
		checklistItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
	}

}

//	MARK - Search Bar Methods
extension ChecklistController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		
		checklistItems = checklistItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
		
		tableView.reloadData()
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchBar.text?.count == 0 {
			loadItems()
			
			DispatchQueue.main.async {
				searchBar.resignFirstResponder()
			}
		}
	}
}


