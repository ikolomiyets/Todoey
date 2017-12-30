//
//  ViewController.swift
//  Todoey
//
//  Created by Igor Kolomiyets on 25/12/2017.
//  Copyright © 2017 IKtech. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: SwipeTableViewController {
    let realm : Realm = (UIApplication.shared.delegate as! AppDelegate).realm!
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    var toDoItems : Results<Item>?
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
    }
    
    // MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let item = toDoItems?[indexPath.row] {
            cell.textLabel?.text = "\(item.title)"
            cell.accessoryType = item.done ? .checkmark : .none
        }
        
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = toDoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
//                    realm.delete(item)
                }
            } catch {
                print("Error while updating the item")
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
    // MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let category = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        category.items.append(newItem)
                    }
                } catch {
                    print("Error saving data \(error)")
                }
                
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func loadItems() {
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let item = toDoItems?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(item)
                }
            } catch {
                print("Error while updating the item")
            }
        }
    }
}


// MARK: - Search Bar Delegate Methods
extension TodoListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        toDoItems = toDoItems?.filter(NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)).sorted(byKeyPath: "dateCreated", ascending: true)
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

