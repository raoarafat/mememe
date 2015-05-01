//
//  MyCustomViewController.swift
//  MemeMe
//
//  Created by Arafat on 4/27/15.
//  Copyright (c) 2015 Arafat. All rights reserved.
//

import UIKit

class MyCustomViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Right Bar Button with image
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.Add , target: self, action:"showEditorViewController")
        
        //Left Bar Button with image
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.Edit , target: self, action:"editingRow")
    }
    
    func editingRow(){
        
        // Do noting...
    }
    
    func showEditorViewController(){
        
        // Do noting...
    }
    
    
}
