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
 @IBAction func chooseImageFromPicker(_ sender: Any) {
        alert = UIAlertController(title: "Do want to add media?", message: "Choose any of them.", preferredStyle: .actionSheet)

        alert!.addAction(UIAlertAction(title: "Open Gallary", style: .default, handler: { (addImage) in
        
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
                    
        }))

       alert!.addAction(UIAlertAction(title: "Open Camera", style: .default, handler: { (addImage2) in

        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }else{
            self.alert2 = UIAlertController(title: "Sorry We are unable to open camera", message: "Choose from gallary.", preferredStyle: .alert)
            self.alert2!.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self.present(self.alert2!, animated: true)
        }
        
       }))
       self.present(alert!, animated: true)
        
    }
 func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage: UIImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        let res = saveImage(image: selectedImage)
        print("saved image: ", res!)
        selectedImage.accessibilityUserInputLabels = [res!]
        newNote?.strFiles.append(res!)
        cvFiles.reloadData()
        dismiss(animated: true, completion: nil)
    }

  private func saveImage(image: UIImage) -> String? {
        let fileName = "Image_\(getTimeStamp()).jpeg"
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
        if let imageData = image.jpegData(compressionQuality: 1.0) {
           try? imageData.write(to: fileURL, options: .atomic)
           return fileName // ----> Save fileName
        }
        print("Error saving image")
        return nil
    }

 private func load(fileName: String) -> UIImage? {
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }  

 @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            showPopup(vc: self, title: "Save error", msg: error.localizedDescription, btnText: "Cancel")
        } else {
            if let url = URL(string: image.accessibilityUserInputLabels.first!) {
                let fileName = url.lastPathComponent

                print("clicked image",fileName)
                newNote?.strFiles.append(fileName)
            }
            showPopup(vc: self, title: "Saved!", msg: "Your image has been saved to your photos.", btnText: "Okay")
            cvFiles.reloadData()
        }
    }


 func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

 @IBAction func recordAudio(_ sender: Any) {
        recordingSession = AVAudioSession.sharedInstance()

        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.recordTapped()
                    } else {
                        // failed to record!
                    }
                }
            }
        } catch {
            // failed to record!
        }
    }
}
