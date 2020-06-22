//
//  AddNotesVC.swift
//  NoteApp_Goal_Diggers_FP
//
//  Created by Gagan on 2020-06-22.
//  Copyright © 2020 Gagan. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation
import CoreLocation



class AddNotesVC: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, CLLocationManagerDelegate , AVAudioRecorderDelegate{


    @IBOutlet weak var Addtitle: UITextField!
    
    @IBOutlet weak var addDesc: UITextView!
    @IBOutlet weak var Addcategory: UITextField!
    var newNote: NSManagedObject?
    
    
    var context: NSManagedObjectContext?
    
    var categoryName: String?
    var isNewNote = true
    var isToSave = false
    var noteTitle: String?
    
    var locationManager = CLLocationManager()
    var currentLocation = CLLocationCoordinate2D()
    
     let mainColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
 Addcategory.text = categoryName!
        addDesc.delegate = self as! UITextViewDelegate
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        // Do any additional setup after loading the view.
    }
    

    
    
    @IBAction func saveBtn(_ sender: UIButton) {
       
                
           
        
    }
    
    
    func okAlert(title: String){
           let titleString = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: mainColor, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
           
           let alertController = UIAlertController(title: "" , message: nil, preferredStyle: .alert)
           alertController.setValue(titleString, forKey: "attributedTitle")
           
           let okAction = UIAlertAction(title: "Okay", style: .default) { (action) in
               if self.isToSave{
                   self.navigationController?.popViewController(animated: true)
               }
               self.isToSave = false
           }
           okAction.setValue(UIColor.black, forKey: "titleTextColor")
           alertController.addAction(okAction)
           
           self.present(alertController, animated: true)
           
       }
       
       func saveData(){
           do{
               try context!.save()
           }catch{
               print(error)
           }
       }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
