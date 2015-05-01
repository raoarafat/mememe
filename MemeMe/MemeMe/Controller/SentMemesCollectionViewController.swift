//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Arafat on 4/26/15.
//  Copyright (c) 2015 Arafat. All rights reserved.
//

import UIKit

let reuseIdentifier = "memeCollectionViewCell"

class SentMemesCollectionViewController: MyCustomViewController,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var isDeleteModeOn : Bool = true
    
    
    // MARK: Controller Initial Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register collection view cell NIB...
        
        //self.collectionView!.registerClass(MemeCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
       // collectionView!.registerClass(MemeCollectionViewCell.self, forCellWithReuseIdentifier: "MemeCollectionViewCell")
       // collectionView!.registerNib(UINib(nibName: "MemeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        // Reload Collection View with updating MEME & Off deleting mode...
        isDeleteModeOn = true
        self.collectionView.reloadData()
    }
    
    // MARK: UIStoryboardSegue methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Check Segue identifier
        if(segue.identifier == "MemeDetailViewController"){
            
            let memeDetailVC: MemeDetailViewController = segue.destinationViewController as! MemeDetailViewController
            let indexPath : NSIndexPath = sender as! NSIndexPath
            // Set Memed image
            memeDetailVC.meme =  MemeSingleton.sharedInstance.memes[indexPath.row]
        }
    }
    
    // MARK: Custom Methods
    
    // Override method to open Meme Editor mode
    override func showEditorViewController() {
        
        self.performSegueWithIdentifier("MemeEditorView", sender: self)
    }
    
    // Override method to Delete Meme
    override func editingRow(){
        
        // Check IF Collection is in Delete Mode
        if(isDeleteModeOn){
            // Set Collection to Normal Mode
            isDeleteModeOn = false
        }else{
            // Set Collection to Delete Mode
            isDeleteModeOn = true
        }
        
        // Reload Collection View
        self.collectionView.reloadData()
        
    }
    
    // MARK: @IBAction Methods
    @IBAction func deleteMemed(sender: UIButton) {
        
        var tag : NSInteger = sender.tag
        
        // Removing Meme from Array
        MemeSingleton.sharedInstance.memes.removeAtIndex(tag)

        // Reload Collection View
        self.collectionView.reloadData()
    }
    
    // MARK: UICollection View DataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of items in the section
        return MemeSingleton.sharedInstance.memes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // Configure the cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MemeCollectionViewCell
        
        
        //let cell : MemeCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MemeCollectionViewCell
        
        
        // Get meme object from meme array...
        var meme : Meme = MemeSingleton.sharedInstance.memes[indexPath.row]
        
        cell.imageMeme?.image = meme.memeImage
        cell.btnRemoveMeme?.hidden = isDeleteModeOn
        cell.btnRemoveMeme?.tag = indexPath.row
        cell.btnRemoveMeme?.addTarget(self, action: "deleteMemed:", forControlEvents: .TouchUpInside)
        
        return cell
    }
    
    // MARK: UICollection View Delegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        
        if(isDeleteModeOn){
            
            // perform segue with identifier
            self.performSegueWithIdentifier("MemeDetailViewController", sender:indexPath)
        }
    }
}
