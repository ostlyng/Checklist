//
//  CategoryController.swift
//  Checklist
//
//  Created by Anne Kristine on 07/10/2018.
//  Copyright © 2018 Thomas Østlyng. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryController: UITableViewController {
	
	let realm = try! Realm()
	
	var categories: Results<Category>?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		loadCategories()
    }

    // MARK: - TableView data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
        return categories?.count ?? 1
    }
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
		
		cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"
		
		return cell
	}
	
	// MARK: - Tableciew Delegate Methods
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "goToItems", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let destinationVC = segue.destination as! ChecklistController
		
		if let indexPath = tableView.indexPathForSelectedRow {
			destinationVC.selectedCategory = categories?[indexPath.row]
		}
	}
	
	// MARK: - Data Manipulation Methods
	
	func save(category: Category) {
		do {
			try realm.write {
				realm.add(category)
			}
		} catch {
			print("Error saving category \(error)")
		}
		self.tableView.reloadData()
	}
	
	func loadCategories() {
		
		categories = realm.objects(Category.self)
		
		tableView.reloadData()
	}

	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		var textField = UITextField()
		let alert = UIAlertController(title: "Add New Category Item", message: "", preferredStyle: .alert)
		let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
			
			let newCategory = Category()
			newCategory.name = textField.text!
			
			self.save(category: newCategory)
		}
		
		alert.addTextField { (alertTextField) in
			alertTextField.placeholder = "Create new item"
			textField = alertTextField
		}
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
}
