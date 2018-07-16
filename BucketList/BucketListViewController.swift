//
//  ViewController.swift
//  BucketList
//
//  Created by Isidro Arzate on 7/5/18.
//  Copyright © 2018 Isidro Arzate. All rights reserved.
//

import UIKit
import CoreData

let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate {

    var items = [NSDictionary]()
    override func viewDidLoad() {
        fetchAllItems()
//        call the get all tasks function in the taskmodel file

        super.viewDidLoad()
//        fetchAllItems()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]["objective"] as? String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected")
        print(indexPath)
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItemSegue", sender: indexPath)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        let item = items[indexPath.row]
//        managedObjectContext.delete(item)
//        do{
//           try managedObjectContext.save()
//        }
//        catch{
//            print ("\(error)")
//        }
//        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is UIBarButtonItem{
//        if segue.identifier == "AddItemSegue"{
        let navigationController = segue.destination as! UINavigationController
        let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
        addItemTableViewController.delegate = self
        }
        else if sender is IndexPath{
//        else if segue.identifier == "EditItemSegue"{
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            addItemTableViewController.delegate = self

            let indexPath = sender as! NSIndexPath
//            let item = items[indexPath.row]
//            addItemTableViewController.item = item.text!
            addItemTableViewController.indexPath = indexPath
        }
    }
    
    func fetchAllItems(){
        items.removeAll()
        TaskModel.getAllTasks() {
            data, response, error in
            do {
                //                try and grab the tasks from ApI and print/use in success
                if let tasks = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let alltasks = tasks["tasks"] as? NSArray{
                        for task in alltasks{
                            let taskDict = task as! NSDictionary
                            self.items.append(taskDict)
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                //                if error in grabbing data print
                print("Something went wrong")
            }
        }
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
//        do {
//        let result = try managedObjectContext.fetch(request)
//        items = result as! [BucketListItem]
//        }
//        catch{
//            print("\(error)")
//        }
    }
    
    func cancelButtonPressed(by controller:AddItemTableViewController) {
        print("I am a hidden controller")
        dismiss(animated: true, completion: nil)
    }
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?) {
        print(text)
        TaskModel.addTaskWithObjective(objective: text){
            data, response, error in
            self.fetchAllItems()
        }
        

//        if let ip = indexPath{
//            let item = items[ip.row]
//            item.text = text
//        }
//        else{
//            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
//            item.text = text
//            items.append(item)
//        }
//        do {
//           try managedObjectContext.save()
//        }
//        catch{
//            print("\(error)")
//        }

        dismiss(animated: true, completion: nil)
    }



}

