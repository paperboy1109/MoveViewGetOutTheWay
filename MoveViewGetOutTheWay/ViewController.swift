//
//  ViewController.swift
//  MoveViewGetOutTheWay
//
//  Created by Daniel J Janiak on 4/2/16.
//  Copyright © 2016 Daniel J Janiak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var textField1: UITextField!
    
    var initialVerticalPosForView: CGFloat!
    
    let textFieldDelegate = TextFieldDelegate()
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor() ,//TODO: Fill in appropriate UIColor,
        NSForegroundColorAttributeName : UIColor.whiteColor(), //TODO: Fill in UIColor,
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -1.0 //TODO: Fill in appropriate Float
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialVerticalPosForView = self.view.frame.origin.y
        print(initialVerticalPosForView)
        
        textField1.defaultTextAttributes = memeTextAttributes
        textField1.textAlignment = .Center
        textField1.text = "Hello"
        
        textField1.delegate = textFieldDelegate
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as!NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if textField1.isFirstResponder() {
            if self.view.frame.origin.y >= initialVerticalPosForView {
                self.view.frame.origin.y -= getKeyboardHeight(notification)
            }
            
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        //print(self.view.frame.origin.y)
        //print(initialVerticalPosForView - getKeyboardHeight(notification))
        
        if textField1.isFirstResponder() {
            if self.view.frame.origin.y < initialVerticalPosForView {
                //self.view.frame.origin.y += getKeyboardHeight(notification)
                self.view.frame.origin.y = initialVerticalPosForView
            }
        }
        
    }
    
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        
    }

    



}

