//
//  AddNotesTVCTableViewController.swift
//  NoteApp_Goal_Diggers_FP
//
//  Created by Gagan on 2020-06-15.
//  Copyright © 2020 Gagan. All rights reserved.
//

import UIKit
import CoreData
class AddNotesTVCTableViewController: UITableViewController {
     var categoryName: String?
     var notes: [NSManagedObject]?
     var context: NSManagedObjectContext?
       
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        self.navigationItem.rightBarButtonItem = self.editButtonItem
//        self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.8857288957, green: 0.9869052768, blue: 0.9952554107, alpha: 1)
//        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
        loadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes?.count ?? 0
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell") as! Notescell
               //            print(notes![indexPath.row].value(forKey: "title") as! String)
               cell.setData(note: notes![indexPath.row])
               return cell
               
    }
   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               // Delete the row from the data source
               
               self.context!.delete(self.notes![indexPath.row])
               self.notes?.remove(at: indexPath.row)
               saveData()
               tableView.deleteRows(at: [indexPath], with: .fade)
               
           } else if editingStyle == .insert {
               // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
           }
       }
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
            if let destination = segue.destination as? AddNotesTVCTableViewController{
                destination.categoryName = self.categoryName
                
                if let noteCell = sender as?  Notescell{
                    // old note
                //    destination.isNewNote = false
              //      destination.noteTitle = noteCell.title.text
                    
                }
                
                if let btn = sender as? UIBarButtonItem{
                    // new note
              //      destination.isNewNote = true
                }
            }
            
        }
        
        
        func loadData() {
            notes = []
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Newnotes")
            request.predicate = NSPredicate(format: "category = %@", categoryName!)
            
            do{
                let results = try context!.fetch(request)
                if results is [NSManagedObject]{
                    if results.count > 0{
                        notes = results as! [NSManagedObject]
                    }
                }
                
                tableView.reloadData()
            }catch{
                print(error)
            }
        }
        
        
        func saveData(){
            do{
                try context!.save()
            }catch{
                print(error)
            }
        }
        
        override func viewWillAppear(_ animated: Bool) {
            
            loadData()
            
        }
        
        
    }
