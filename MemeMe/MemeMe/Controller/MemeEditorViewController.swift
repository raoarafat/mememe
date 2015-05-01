//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Arafat on 4/27/15.
//  Copyright (c) 2015 Arafat. All rights reserved.
//

import UIKit


class MemeEditorViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var navToolbar: UIToolbar!
    @IBOutlet weak var barBtnSentMeme: UIBarButtonItem!
    @IBOutlet weak var barBtnCamera: UIBarButtonItem!
    @IBOutlet weak var txtTop: UITextField!
    @IBOutlet weak var txtBottom: UITextField!
    @IBOutlet weak var imagePickerView: UIImageView!
    
    var imagePickerController: UIImagePickerController!
    let hideKeboardTextFieldDelegate = HideKeboardTextFieldDelegate()
    
    // MARK: Controller Initial Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting Custom delegate to text field's...
        txtBottom.delegate = hideKeboardTextFieldDelegate
        txtTop.delegate = hideKeboardTextFieldDelegate
        
        // Left Toolbar Button with image...
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.Action , target: self, action:"sentMeme:")
        
        // Right Toolbar Button with image...
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style:UIBarButtonItemStyle.Plain, target: self, action: "cancel")
        
        // Set Camera Availability...
        self.barBtnCamera.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        // Disable Sent Meme button first time launch...
        self.barBtnSentMeme.enabled = false;
        
        // Initializes UIImagePickerController & It's delegate
        self.imagePickerController = UIImagePickerController()
        self.imagePickerController.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        
        // Subscribe to the keyboard notification
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeToKeyboardNotifications()
    }
    
    // MARK: Custom Methods
    
    // Hide This VC...
    func cancel(){
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func save(memedImaged : UIImage){
        
        var meme = Meme(toptxt: txtTop.text!, bottomtxt: txtBottom.text!, image: imagePickerView.image!, memeImage: generateMemeImage())
        MemeSingleton.sharedInstance.memes.append(meme)
    }
    
    // MARK: Keyboard Methods
    
    // Move the view up when the keyboard covers the text field
    func keyboardWillShow(notification : NSNotification){
        
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    // Move the view down when the keyboard will hide
    func keyboardWillHide(notification : NSNotification){
        
        self.view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    // Get Keyboard Height
    func getKeyboardHeight(notification : NSNotification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        // Check Textfield IF it is Bottom only...
        if txtBottom.editing {
            return keyboardSize.CGRectValue().height
        }
        else {
            return 0
        }
    }
    
    // Create UIImage that combines together the Image views  and the labels
    func generateMemeImage() -> UIImage{
        
        // Hide Nav & Bottom Toolbar to Generate Meme Image
        navToolbar.hidden = true
        bottomToolbar.hidden = true
        
        // render view to an image & create Memed Image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Unhide Nav & Bottom Toolbar after Generating Meme Image
        navToolbar.hidden = false
        bottomToolbar.hidden = false
        
        // Return Memed Image
        return memedImage
    }
    
    // MARK: NSNotificationCenter
    
    // Subscribe's to UIKeyboardWillShowNotification & UIKeyboardWillHideNotification
    func subscribeToKeyboardNotifications() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // Unsubscribe's to UIKeyboardWillShowNotification & UIKeyboardWillHideNotification
    func unsubscribeToKeyboardNotifications() {
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // MARK: @IBAction Methods
    @IBAction func cancelEditorView(sender: AnyObject) {
        // Dismiss Modal View
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func sentMeme(sender: AnyObject) {
        
        // Get Memed Image
        let memedImage = self.generateMemeImage()
        let activity = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        // Compltion Handler
        activity.completionWithItemsHandler = {
            (type: String!, success: Bool, items: [AnyObject]!, err:NSError!) -> Void in
            
            // Save it b IF Success...
            if(success){
                self.save(memedImage)
            }
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        // Present Activity Controller
        presentViewController(activity, animated: true, completion: nil)
        
    }
    @IBAction func pickAnImageFromLibrary(sender: AnyObject) {
        
        // Setting ImagePicker Source Type to PhotoLibrary
        self.imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(self.imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        
        // Setting ImagePicker Source Type to Camera
        self.imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(self.imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerController Delegate Methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            // Set Selected image
            imagePickerView.image = image
            
            // Enabling Share buttob after image selected
            self.barBtnSentMeme.enabled = true;
            
            // Dismiss Editor View
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
}
