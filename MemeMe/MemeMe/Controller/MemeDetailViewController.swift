//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Arafat on 4/29/15.
//  Copyright (c) 2015 Arafat. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var imageViewMeme: UIImageView!
    var meme : Meme!
    
    // MARK: Controller Initial Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Right Bar Button with image
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.Add , target: self, action:"showEditorViewController")
        
        // Set Memed Image
        self.imageViewMeme.image = meme.memeImage
    }
    
    // MARK: Custom Methods
    
    //  To open Meme Editor mode
     func showEditorViewController() {
        
        self.performSegueWithIdentifier("MemeEditorView", sender: self)
    }
    
    
}
