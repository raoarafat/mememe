//
//  HideKeboardTextFieldDelegate.swift
//  MemeMe
//
//  Created by Arafat on 4/30/15.
//  Copyright (c) 2015 Arafat. All rights reserved.
//

import UIKit

class HideKeboardTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        // Hide Keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range:NSRange, replacementString string: String) -> Bool {
        
        // Get Range location
        let lowercaseCharRange = (string as NSString).rangeOfCharacterFromSet(NSCharacterSet.lowercaseLetterCharacterSet())
        
        // Check IF String is in Lowercase
        if (lowercaseCharRange.location != NSNotFound) {
            
            // Change string lower case to upper case
            textField.text = (textField.text as NSString).stringByReplacingCharactersInRange(range, withString:string.uppercaseString)
            return false
        }
        return true
    }
}
