//
//  addnotesViewController.swift
//  NoteApp_Goal_Diggers_FP
//
//  Created by Gagan on 2020-06-20.
//  Copyright © 2020 Gagan. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation
import CoreLocation

class addnotesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate , AVAudioRecorderDelegate{
      var newNote: NSManagedObject?
    
       var context: NSManagedObjectContext?
       
       var categoryName: String?
       var isNewNote = true
       var isToSave = false
       var noteTitle: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
