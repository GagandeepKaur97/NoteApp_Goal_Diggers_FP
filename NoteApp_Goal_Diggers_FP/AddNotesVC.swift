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
    @IBOutlet weak var recordbtn: UIButton!
    
    @IBOutlet weak var stopbtn: UIButton!
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var addDesc: UITextView!
    @IBOutlet weak var Addcategory: UITextField!
    var newNote: NSManagedObject?
    
    var isPlaying = false
    var isRecording = false
    var recordingSession: AVAudioSession!
    var audioRecorder:AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var records = 0
    

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
        
       stopbtn.layer.cornerRadius = 30
       recordbtn.layer.cornerRadius = 30
// Addcategory.text = categoryName!
//        addDesc.delegate = self as? UITextViewDelegate
 recordingSession = AVAudioSession.sharedInstance()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        // Do any additional setup after loading the view.
    
//     if !isNewNote{
//              recordbtn.isHidden = false
//                showCurrentNote(noteTitle!)
//                // show all data to user
//
//                icMap.isEnabled = true
//                navigationItem.title = "Edit note"
//            }else{
//               recordbtn.isHidden = true
//                icMap.isEnabled = false
//                AVAudioSession.sharedInstance().requestRecordPermission { (granted) in
//
//                    if !granted{
//
//
//
//                    }
//
//
//                }
//            }
            
//            let hideKeyboard = UITapGestureRecognizer(target: self, action: #selector(onTapped))
//            view.addGestureRecognizer(hideKeyboard)
//
//            // tap gesture for seklecting image
//            let tapG = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
//           addImage.addGestureRecognizer(tapG)
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            
    //        recordingSession = AVAudioSession.sharedInstance()

            do {
                try recordingSession.setCategory(.playAndRecord, mode: .default)
                try recordingSession.setActive(true)
                
            } catch {
                // failed to record!
        }
        
//    @objc func onTapped(){
//          Addtitle.resignFirstResponder()
//        addDesc.resignFirstResponder()
//        Addcategory.resignFirstResponder()
//       }

       //get user's current location
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           currentLocation = manager.location!.coordinate
       }

       func showCurrentNote(_ title: String){

           Addtitle.isEnabled = false
           let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
           request.predicate = NSPredicate(format: "title = %@", title)

           do{
               let results = try context!.fetch(request)
               newNote = results[0] as! NSManagedObject

              Addtitle.text = newNote!.value(forKey: "title") as! String
               addDesc.text = newNote!.value(forKey: "desc") as! String
//               noteImageView.image = UIImage(contentsOfFile: getFilePath("/\(txtTitle.text!)_img.txt"))
//
           }catch{
               print("unable to fech note-data")
           }
       }



//  @IBAction func saveBtn(_ sender: UIButton) {
       if isNewNote{

                  let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Newnotes")
                  do{
                      let results = try self.context!.fetch(request)
                      var alreadyExists = false
                      if results.count > 0{
                          for result in results as! [NSManagedObject]{
                              if Addtitle.text! == result.value(forKey: "title") as! String{
                                  alreadyExists = true
                                  break
                              }
                          }
                      }

                      if !alreadyExists {
                          if (Addtitle.text!.isEmpty || addDesc.text! == "Write note...." || addDesc.text!.isEmpty || Addcategory.text!.isEmpty){
                              // empty field
                              okAlert(title: "None of the fields can be empty!!")

                          }else{
               //               self.addData()
                              isNewNote = false
                          }

                      } else{
                          okAlert(title: "Note with name '\(Addtitle.text!)' already exists!")
                          isNewNote = true
                      }
                  }catch{
                      print(error)
                  }

              }else{

                  addData()

              }
          }

          func addData(){

              if isNewNote{
                  newNote = NSEntityDescription.insertNewObject(forEntityName: "Newnotes", into: context!)

              }

              newNote!.setValue(Addtitle.text!, forKey: "title")
              newNote!.setValue(addDesc.text!, forKey: "desc")
              newNote!.setValue(categoryName!, forKey: "category")
              let createdDate =  isNewNote ? Date() : (newNote?.value(forKey: "datetime")! as! Date)
              newNote!.setValue(createdDate, forKey: "datetime")
              newNote!.setValue(Addcategory.text!.uppercased(), forKey: "category")
              let lat = isNewNote ? currentLocation.latitude : newNote?.value(forKey: "lat") as! Double
              newNote?.setValue(lat, forKey: "lat")
              let long = isNewNote ? currentLocation.longitude : newNote?.value(forKey: "long") as! Double
              newNote?.setValue(long, forKey: "long")

             updateCatagoryList()
              // save image to file
             // saveImageToFile()
              saveData()

              isToSave = true
              okAlert(title: isNewNote ? "Note saved successfully!!" : "Updated successfully!!")

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
    
    


    func updateCatagoryList(){

           var catagoryPresent = false
           let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Categories")
           request.returnsObjectsAsFaults = false

           // we find our data
           do{
               let results = try context?.fetch(request) as! [NSManagedObject]

               for r in results{

                   if Addcategory.text! == (r.value(forKey: "notename") as! String) {
                       catagoryPresent = true;
                       break

                   }

               }
           } catch{
               print("Error2...\(error)")
           }


           if !catagoryPresent{

               let newFolder = NSEntityDescription.insertNewObject(forEntityName: "Categories", into: context!)
               newFolder.setValue(Addcategory.text!, forKey: "notename")
               saveData()

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
    


