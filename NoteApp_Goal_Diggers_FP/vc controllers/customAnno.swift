//
//  customAnno.swift
//  NoteApp_Goal_Diggers_FP
//
//  Created by Gagan on 2020-06-18.
//  Copyright © 2020 Gagan. All rights reserved.
//

import Foundation
import MapKit

class CustomAnno: NSObject, MKAnnotation{

    init(coordinate: CLLocationCoordinate2D, identifier: String) {
        self.coordinate = coordinate
        self.identifier = identifier
    }

    var coordinate: CLLocationCoordinate2D
    var identifier: String
    
}
