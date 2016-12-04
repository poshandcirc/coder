//
//  ViewController.swift
//  SwarthmoreKeyboard
//
//  Created by Cassy Stone on 12/3/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var typedMessageTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func decodeMessage(sender: AnyObject) {
        var counter = 0
        var indexCount = 0
        var uncodedString = ""
        let codedMess = typedMessageTextView.text!
        print(codedMess)
//        let backwardsMess = codedMess.characters.reverse()
//        for char in backwardsMess {
//            if char == "\u{0000}" {
//                counter += 1
//            }
//        }
//        print(counter)
        counter = 6
        
        let alphabetArray = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        for char in codedMess.characters {
            for letter in alphabetArray {
                if String(char) != letter {
                    indexCount += 1;
                }
            }
            if ((indexCount - counter) >= 0) {
                uncodedString += alphabetArray[indexCount - counter]
            } else {
                uncodedString += alphabetArray[indexCount - counter + 25]
            }
            indexCount = 0
        }
        typedMessageTextView.text = uncodedString
    }
    
//    func keyboardWillShow(notification: NSNotification) {
//        typedMessageTextView.text = ""
//    }
    
}

