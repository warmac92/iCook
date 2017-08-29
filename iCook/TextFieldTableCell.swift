//
//  TextFieldTableCell.swift
//  iCook
//
//  Created by Niranjan Ravichandran on 28/11/15.
//  Copyright © 2015 Team. All rights reserved.
//

import UIKit

class TextFieldTableCell: UITableViewCell {

    @IBOutlet var cellLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
