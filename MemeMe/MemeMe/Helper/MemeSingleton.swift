//
//  MemeSingleton.swift
//  MemeMe
//
//  Created by Arafat on 4/28/15.
//  Copyright (c) 2015 Arafat. All rights reserved.
//

import UIKit

class MemeSingleton: NSObject {
    
    // Create's Meme Array
    var memes = [Meme]()
    
    // Create a class variable as a computed type property
    class var sharedInstance: MemeSingleton {
        // Nested within the class variable is a struct called Singleton
        struct Singleton {
            // Singleton wraps a static constant variable named instance
            static let instance = MemeSingleton()
        }
        // Returns the computed type property
        return Singleton.instance
    }
    
    // initializer
    override init() {
        // Do noting...
    }
}
