//
//  ItemsTableViewController.swift
//  Collector
//
//  Created by Peter Milligan on 2020/04/20.
//  Copyright © 2020 John Milligan. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController {
    
    var items : [Item] = []
    
    var selectedItem : Item?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getItems()
    }
    
    func getItems() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreDataStuff = try? context.fetch(Item.fetchRequest()) as? [Item] {
                let coreDataItems = coreDataStuff
                items = coreDataItems
                tableView.reloadData()
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        if let imageData = item.image {
            cell.imageView?.image = UIImage(data: imageData)
        }
        
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Delete")
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                
                let item = items[indexPath.row]
                
                context.delete(item)
                getItems()
            }
        }
    }
    
}
