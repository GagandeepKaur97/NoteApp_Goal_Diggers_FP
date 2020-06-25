//
//  Notescell.swift
//  NoteApp_Goal_Diggers_FP
//
//  Created by Gagan on 2020-06-21.
//  Copyright © 2020 Gagan. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation


class Notescell: UITableViewCell {

    @IBOutlet weak var lbtitle: UILabel!
    
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbLocation: UILabel!
    
    @IBOutlet weak var lbTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(note: NSManagedObject){
            lbtitle.text = note.value(forKey: "title") as! String
            
            //get date
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "dd/MM/yyyy"
            let formattedDate = dateFormat.string(from: note.value(forKey: "dateTime") as! Date)
           lbDate.text = formattedDate

            //get time
            let timeFormat = DateFormatter()
            timeFormat.dateFormat = "HH:MM:SS"
            let formattedTime = timeFormat.string(from: note.value(forKey: "dateTime") as! Date)
           lbTime.text = formattedTime
            
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
                    self.lbLocation.text = address
                }
            }
        }

    }


