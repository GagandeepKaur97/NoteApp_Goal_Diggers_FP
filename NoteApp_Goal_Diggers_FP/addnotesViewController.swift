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

class addnotesViewController: UIViewController, CLLocationManagerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,AVAudioRecorderDelegate, AVAudioPlayerDelegate
      var newNote: NSManagedObject?
    
       var context: NSManagedObjectContext?
        var imagePicker: UIImagePickerController!
    var alert : UIAlertController?
    var alert2 : UIAlertController?
    var delegate : AddNotesTVCTableViewController?
    var currentNote: Note?
    var newNote: Note?
    var manager: CLLocationManager?
    var userLocation: CLLocation?
    
    var audioPlayer: AVAudioPlayer?
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!     
      var categoryName: String?
       var isNewNote = true
       var isToSave = false
       var noteTitle: String?

 @IBOutlet weak var navBar: UINavigationItem!
    
    @IBOutlet weak var cvFiles: UICollectionView!
    
    @IBOutlet weak var txtNote: UITextView! 
   override func viewDidLoad() {
        super.viewDidLoad()
         imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        start()
        initLocation()     
         // Do any additional setup after loading the view.
    }
    //function to start creating note
        func start() {
         var navTitle: String?
        if let currentNote = currentNote{
            navTitle = String((currentNote.noteName.prefix(upTo: (currentNote.noteName.index((currentNote.noteName.startIndex), offsetBy: (currentNote.noteName.count)/2))))) + "....."
            newNote = currentNote
        }else{
            navTitle = "New Note"
            newNote = Note(noteName: "", timeStamp: getTimeStamp())
        }
        navBar.title = navTitle
        txtNote.becomeFirstResponder()
        txtNote.text = newNote?.noteName
        print("files", newNote?.strFiles)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(releaseFocus))
        navigationController?.navigationBar.addGestureRecognizer(tap)
        initCollectionView()
        
    }  
//function to realese focus
 @objc func releaseFocus() {
            txtNote.resignFirstResponder()
    }
//initiazation of collection view
 func initCollectionView() {
        cvFiles.delegate = self
        cvFiles.dataSource = self
        
        cvFiles.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        
        cvFiles.register(UINib(nibName: "AudioCell", bundle: nil), forCellWithReuseIdentifier: "AudioCell")
    }  
}
