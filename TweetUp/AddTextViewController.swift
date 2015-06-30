//
//  AddTextViewController.swift
//  TweetUp
//
//  Created by DEV MODE on 6/29/15.
//  Copyright (c) 2015 DEV MODE. All rights reserved.
//

import UIKit
import Accounts

class AddTextViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!

    var profileImage : UIImage? = nil
    var twitterAccount : ACAccount? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) { // segue command
        let publishPicViewController = segue.destinationViewController as! PublishPicViewController // setting the destination for the segue
        publishPicViewController.profileImage = self.profileImage // allowing pic data to be used by other view controller
        publishPicViewController.imageText = self.textField.text // allowing text from textfield to be used by other view controller 
        publishPicViewController.twitterAccount = self.twitterAccount
    }

}
