//
//  DescriptionTableViewCell.swift
//  iCook
//
//  Created by Niranjan Ravichandran on 24/11/15.
//  Copyright © 2015 Team. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet var titleLable: UILabel!
    @IBOutlet var userDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userDescription.numberOfLines = 0
        userDescription.lineBreakMode = NSLineBreakMode.ByWordWrapping
        userDescription.sizeToFit()
        userDescription.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
