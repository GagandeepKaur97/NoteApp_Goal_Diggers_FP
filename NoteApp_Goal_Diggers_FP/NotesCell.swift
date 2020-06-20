//
//  NotesCell.swift
//  NoteApp_Goal_Diggers_FP
//
//  Created by Gagan on 2020-06-20.
//  Copyright © 2020 Gagan. All rights reserved.
//

import UIKit

class NotesCell: UITableViewCell {

    
    
    @IBOutlet weak var Date: UILabel!
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

}
