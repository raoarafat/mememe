//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Arafat on 4/26/15.
//  Copyright (c) 2015 Arafat. All rights reserved.
//

import UIKit

class SentMemesTableViewController: MyCustomViewController {
    
    
    @IBOutlet weak var tblView: UITableView!
    
    // MARK: Controller Initial Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Launch Editor View if there is no Meme's available
        self.performSegueWithIdentifier("MemeEditorView", sender: self)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        // Reload Table View with updating MEME & Off editing mode...
        self.tblView.setEditing(false, animated: true)
        self.tblView.reloadData()
    }
    
    // MARK: UIStoryboardSegue methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
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
        
        // Check IF Table is in Editing Mode
        if(self.tblView.editing){
            // Set Table to Normal Mode
            self.tblView.setEditing(false, animated: true)
        }else{
            // Set Table to Edit Mode
            self.tblView.setEditing(true, animated: true)
        }
    }
    
    // MARK: - Table view data source method
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return MemeSingleton.sharedInstance.memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "MemeTableViewCell"
        var cell: MemeTableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? MemeTableViewCell
        if cell == nil {
            cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? MemeTableViewCell
        }
        
        // Get meme object from meme array...
        var meme : Meme = MemeSingleton.sharedInstance.memes[indexPath.row]
        
        // Configure the cell...
        cell.backgroundColor = UIColor.clearColor()
        cell.lblMeme!.text = "\(meme.toptxt) \(meme.bottomtxt)"
        cell.imageMeme?.image = meme.memeImage
        
        return cell
    }
    
    // MARK: - Table view delegate method
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        // perform segue with identifier
        self.performSegueWithIdentifier("MemeDetailViewController", sender:indexPath)
    }
    
    // Deleting Memes
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // Check IF Condition is Delete
        if editingStyle == UITableViewCellEditingStyle.Delete {
            // Removing Meme from Array
            MemeSingleton.sharedInstance.memes.removeAtIndex(indexPath.row)
            // Animate delete's Row
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
}
