//
//  KeyboardViewController.swift
//  imagekeyboard
//
//  Created by Cassy Stone on 12/3/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    var randomGen = Int(arc4random_uniform(24) + 1)
    var decoder = ""

    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }
    
    func createButtons(titles: [String]) -> [UIButton] {
    
        var buttons = [UIButton]()
    
        for title in titles {
            let button = UIButton(type: .System) as UIButton
            button.setTitle(title, forState: .Normal)
            button.titleLabel!.font = UIFont(name: "Apple Symbols", size: 25)
            button.setImage(UIImage(named: "SWAT!.png"), forState: .Normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
            button.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
            button.addTarget(self, action: Selector("keyPressed:"), forControlEvents: .TouchUpInside)
            buttons.append(button)
        }
    
    return buttons
    
    }
    
    func keyPressed(sender: AnyObject?) {
        var count = randomGen
        print(count)
        while (count != 0) {
            decoder += "\u{0000}"
            count -= 1
        }
        
        var counter = 0
        
        for char in decoder.characters {
            if char == "\u{0000}" {
                counter += 1
            }
        }
        print(counter)
        
        let button = sender as! UIButton
        let title = button.titleForState(.Normal)
        let alphabetArray = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        var codeLetter = " "
        var indexCount = 0;
        for letter in alphabetArray {
            if title != letter {
                indexCount += 1;
            } else if title == letter {
                if ((indexCount + randomGen) <= 25) {
                codeLetter = alphabetArray[indexCount + randomGen]
                } else {
                    codeLetter = alphabetArray[indexCount + randomGen - 26]
                }
            }
        }
        if title == "DELETE" {
            (textDocumentProxy as UIKeyInput).deleteBackward()
        } else if title == "DONE" {
            (textDocumentProxy as UIKeyInput).insertText(decoder)
        }
        else {
        (textDocumentProxy as UIKeyInput).insertText(codeLetter)
        }
    }
    
    func addConstraints(buttons: [UIButton], containingView: UIView) {
        for (index, button) in buttons.enumerate() {
            var topConstraint = NSLayoutConstraint(item: button, attribute: .Top, relatedBy: .Equal, toItem: containingView, attribute: .Top, multiplier: 1.0, constant: 1)
            var bottomConstraint = NSLayoutConstraint(item: button, attribute: .Bottom, relatedBy: .Equal, toItem: containingView, attribute: .Bottom, multiplier: 1.0, constant: -1)
            var leftConstraint: NSLayoutConstraint!
            if index == 0 {
                leftConstraint = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: containingView, attribute: .Left, multiplier: 1.0, constant: 1)
            } else {
                leftConstraint = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: buttons[index-1], attribute: .Right, multiplier: 1.0, constant: 1)
                var widthConstraint = NSLayoutConstraint(item: buttons[0], attribute: .Width, relatedBy: .Equal, toItem: button, attribute: .Width, multiplier: 1.0, constant: 0)
                containingView.addConstraint(widthConstraint)
            }
            
            var rightConstraint: NSLayoutConstraint!
            if (index == buttons.count - 1) {
                rightConstraint = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: containingView, attribute: .Right, multiplier: 1.0, constant: -1)
            } else {
                rightConstraint = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: buttons[index+1], attribute: .Left, multiplier: 1.0, constant: -1)
            }
            
            containingView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "KeyboardView", bundle: nil)
        let objects = nib.instantiateWithOwner(self, options: nil)
        view = objects[0] as! UIView;
    
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .System)
    
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
    
        self.nextKeyboardButton.addTarget(self, action: #selector(advanceToNextInputMode), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.nextKeyboardButton)
    
        self.nextKeyboardButton.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor).active = true
        self.nextKeyboardButton.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor).active = true
        
        let buttonTitles = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
        let buttonTitles1 = ["A", "S", "D", "F", "G", "H", "K", "L"]
        let buttonTitles2 = ["Z", "X", "C", "V", "B", "N", "M"]
        let buttonTitlesNums = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
        let buttonSpaceBar = ["DONE", "SPACE", "DELETE"]
        
        var buttons = createButtons(buttonTitles)
        var buttons1 = createButtons(buttonTitles1)
        var buttons2 = createButtons(buttonTitles2)
        var buttonNums = createButtons(buttonTitlesNums)
        var buttonSpace = createButtons(buttonSpaceBar)
        
        var topRow = UIView(frame: CGRectMake(0, 0, 320, 40))
        var secondRow = UIView(frame: CGRectMake(0, 40, 320, 40))
        var thirdRow = UIView(frame: CGRectMake(0, 80, 320, 40))
        var fourthRow = UIView(frame: CGRectMake(0, 120, 320, 40))
        var spaceRow = UIView(frame: CGRectMake(0, 160, 320, 40))
        
        for button in buttonNums {
            topRow.addSubview(button)
        }
        
        for button in buttons {
            secondRow.addSubview(button)
        }
        
        for button in buttons1 {
            thirdRow.addSubview(button)
        }
        
        for button in buttons2 {
            fourthRow.addSubview(button)
        }
        
        for button in buttonSpace {
            spaceRow.addSubview(button)
        }
        
        
        self.view.addSubview(topRow)
        self.view.addSubview(secondRow)
        self.view.addSubview(thirdRow)
        self.view.addSubview(fourthRow)
        self.view.addSubview(spaceRow)
        
        addConstraints(buttonNums, containingView: topRow)
        addConstraints(buttons, containingView: secondRow)
        addConstraints(buttons1, containingView: thirdRow)
        addConstraints(buttons2, containingView: fourthRow)
        addConstraints(buttonSpace, containingView: spaceRow)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }

}
