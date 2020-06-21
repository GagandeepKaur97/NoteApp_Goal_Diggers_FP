//
//  NotesCell.swift
//  NoteApp_Goal_Diggers_FP
//
//  Created by Gagan on 2020-06-20.
//  Copyright © 2020 Gagan. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
class NotesCell: UITableViewCell {

 override func awakeFromNib() {
        super.awakeFromNib()
        //self.contentView.backgroundColor = #colorLiteral(red: 0.6439564258, green: 0.8479013801, blue: 0.9977299744, alpha: 1)
        //self.backgroundColor = #colorLiteral(red: 0.6439564258, green: 0.8479013801, blue: 0.9977299744, alpha: 1)
        //self.tintColor = #colorLiteral(red: 0.127715386, green: 0.1686877555, blue: 0.2190790727, alpha: 0.9254236356)
        
    }
    
    /*@IBOutlet weak var Date: UILabel!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var Time: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
      func setData(note: NSManagedObject){
            title.text = note.value(forKey: "title") as! String
            
            //get date
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "dd/MM/yyyy"
            let formattedDate = dateFormat.string(from: note.value(forKey: "dateTime") as! Date)
            Date.text = formattedDate

            //get time
            let timeFormat = DateFormatter()
            timeFormat.dateFormat = "HH:MM:SS"
            let formattedTime = timeFormat.string(from: note.value(forKey: "dateTime") as! Date)
           Time.text = formattedTime
            
            getAddress(lat: note.value(forKey: "lat") as! Double, long: note.value(forKey: "long") as! Double)
        }
        
        func getAddress(lat: Double, long: Double){
            var address = ""
            CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: lat, longitude: long)) { (placemarks, error) in
                if let error = error{
                    print(error)
                    
                } else{
                    
                    if let placemark = placemarks?[0]{
                        if placemark.locality != nil{
                            address += placemark.locality!
                        }
                    }
                    if let placemark = placemarks?[0]{
                        if placemark.subAdministrativeArea != nil{                        address += ", \(placemark.subAdministrativeArea!), "
                        }
                    }
                    if let placemark = placemarks?[0]{
                        if placemark.administrativeArea != nil{
                            address += placemark.administrativeArea!
                        }
                    }
    //                
                    self.location.text = address
                }
            }
        }*/

    }
