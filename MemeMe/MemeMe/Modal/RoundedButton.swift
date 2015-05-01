//
//  RoundedButton.swift
//  MemeMe
//
//  Created by Arafat on 5/1/15.
//  Copyright (c) 2015 Arafat. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = UIColor.blackColor()
        self.layer.cornerRadius = self.bounds.size.width / 2.0;
        self.layer.borderWidth = 1
    }

}
