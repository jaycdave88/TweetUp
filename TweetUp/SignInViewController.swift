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

                let allAccount = account.accountsWithAccountType(accountType) // grab all multiple twitter account 

                if allAccount.count > 0{
                    let twitterAccount = allAccount.last as! ACAccount // grab the last account in the array
                    let requestApi = NSURL(string: "https://api.twitter.com/1.1/account/verify_credentials.json") // create a constant as an NSURL 
                    let userRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestApi, parameters: nil) // user request saying the requestAPi is a get method 
                    userRequest.account = twitterAccount
                    userRequest.performRequestWithHandler({ (response:NSData!, urlResponce : NSHTTPURLResponse!, error:NSError! ) -> Void in

                        var error = NSErrorPointer()

                        let responseDictonary = NSJSONSerialization.JSONObjectWithData(response, options: NSJSONReadingOptions.MutableLeaves, error: error) as! [String : AnyObject]

                        var imageUrl = responseDictonary["profile_image_url_https"] as! String // constant for finding the key and saving it as a string

                        imageUrl = imageUrl.stringByReplacingOccurrencesOfString("_normal", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)

                        var imageRequest = NSURLRequest(URL: NSURL(string : imageUrl)!) // creates a NSURL 

                        NSURLConnection.sendAsynchronousRequest(imageRequest, queue: NSOperationQueue.mainQueue(), completionHandler: { (imageResponce : NSURLResponse!, imageData : NSData!, imageError:NSError!) -> Void in
                            var image = UIImage(data: imageData)
                            self.performSegueWithIdentifier("signInToTextSegue", sender: nil)
                            
                        })

                    })

                } // end if allAccount
            }else{
                println("Acess Not Granted")
            }

        }
        
    }

}
