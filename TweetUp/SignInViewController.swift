//
//  SignInViewController.swift
//  TweetUp
//
//  Created by DEV MODE on 6/29/15.
//  Copyright (c) 2015 DEV MODE. All rights reserved.
//

import UIKit
import Accounts
import Social

class SignInViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        // yoda say...
    }

    @IBAction func signInTwitter(sender: AnyObject) {
        let account = ACAccountStore() //creating a constent that will allow us to use accounts
        let accountType = account.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter) // selecting a twitter account

        account.requestAccessToAccountsWithType(accountType, options: nil) { (granted: Bool, error : NSError!) -> Void in // take the account that we have and request acess to use that account

            if granted{
                println("Access Granted")
            }else{
                println("Acess Not Granted")
            }

        }
        
    }

}
