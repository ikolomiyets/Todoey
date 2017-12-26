//
//  ViewController.swift
//  Todoey
//
//  Created by Igor Kolomiyets on 25/12/2017.
//  Copyright © 2017 IKtech. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray : [Item] = [
        Item("Find Mike"),
        Item("Buy Eggs"),
        Item("Destroy Demogorgon"),
        Item("Buy Item 1"),
        Item("Buy Item 2"),
        Item("Buy Item 3"),
        Item("Buy Item 4"),
        Item("Buy Item 5"),
        Item("Buy Item 6"),
        Item("Buy Item 7"),
        Item("Buy Item 8"),
        Item("Buy Item 9"),
        Item("Buy Item 10"),
        Item("Buy Item 11"),
        Item("Buy Item 12"),
        Item("Buy Item 13"),
        Item("Buy Item 14"),
        Item("Buy Item 15"),
        Item("Buy Item 16"),
        Item("Buy Item 17"),
        Item("Buy Item 18"),
        Item("Buy Item 19"),
        Item("Buy Item 20"),
        Item("Buy Item 21"),
        Item("Buy Item 22"),
        Item("Buy Item 23"),
        Item("Buy Item 24"),
        Item("Buy Item 25")
        ]
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDefaults.removeObject(forKey: "ToDoListArray")
//        if let array = userDefaults.array(forKey: "ToDoListArray") {
//            itemArray = array as! [Item]
//        }
    }
    
    // MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = "\(item.title)"
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemArray.append(Item(textField.text!))
//            self.userDefaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

