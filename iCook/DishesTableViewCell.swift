//
//  DishesTableViewCell.swift
//  iCook
//
//  Created by Niranjan Ravichandran on 27/10/15.
//  Copyright © 2015 Team. All rights reserved.
//

import UIKit

class DishesTableViewCell: UITableViewCell {

    @IBOutlet var userImage: UIImageView!
    @IBOutlet var sellerName: UILabel!
    @IBOutlet var dishImage: UIImageView!
    @IBOutlet var dishName: UILabel!
    @IBOutlet var cellBg: UIView!
    @IBOutlet var ratings: CosmosView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        cellBg.layer.cornerRadius = 6
        userImage.layer.cornerRadius = userImage.frame.height/2
//        userImage.layer.borderWidth = 1
//        userImage.layer.borderColor = UIColor.whiteColor().CGColor
        userImage.clipsToBounds = true
        userImage.contentMode = .ScaleAspectFill
        
        ratings.settings.updateOnTouch = false
//        ratings.settings.colorFilled = UIColor.yellowColor()
        ratings.settings.borderWidthEmpty = 0
        
        dishImage.layer.cornerRadius = 3
        dishImage.contentMode = .ScaleAspectFill
        dishImage.clipsToBounds = true
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
