//
//  ViewController.swift
//  NoteApp_Goal_Diggers_FP
//
//  Created by Gagan on 2020-06-12.
//  Copyright © 2020 Gagan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var imageview: UIImageView!
    
    
    var image: UIImage?
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            
            if let i = image{
                imageview.image = i
            }
            
        }


    }

