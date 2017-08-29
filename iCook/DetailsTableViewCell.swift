//
//  DetailsTableViewCell.swift
//  iCook
//
//  Created by Niranjan Ravichandran on 06/11/15.
//  Copyright © 2015 Team. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var itemLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
