//
//  MemeCollectionViewCell.swift
//  MemeMe
//
//  Created by Arafat on 4/28/15.
//  Copyright (c) 2015 Arafat. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageMeme: UIImageView!
    @IBOutlet weak var btnRemoveMeme: RoundedButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
