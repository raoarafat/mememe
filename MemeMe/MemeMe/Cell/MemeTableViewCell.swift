//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Arafat on 4/28/15.
//  Copyright (c) 2015 Arafat. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    @IBOutlet var lblMeme: UILabel!
    @IBOutlet var imageMeme: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
