//
//  PublishPicViewController.swift
//  TweetUp
//
//  Created by DEV MODE on 6/29/15.
//  Copyright (c) 2015 DEV MODE. All rights reserved.
//

//
import UIKit
import Accounts
import Social

class PublishPicViewController: UIViewController {

    var profileImage : UIImage? = nil

    var imageText = ""
    var twitterAccount : ACAccount? = nil

      @IBOutlet weak var profilePicImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // yoda say ...
        self.profilePicImageView.image = editPic(self.imageText, image: self.profileImage!)
    }

    func editPic(text : String, image : UIImage) -> UIImage{
        
        UIGraphicsBeginImageContext(image.size)

        image.drawInRect(CGRectMake(0, 0, image.size.width, image.size.height)) // setting the points of where to draw ontop of image 

//        UIColor.blackColor().set() // adding black box
        UIColor(white: 0, alpha: 0.6).set() // setting a transparent color box

        CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, image.size.height-(image.size.height * 0.2) , image.size.width, (image.size.height * 0.2))) // setting the black box on the image
// adding text to box

        var rect = CGRectMake(0, image.size.height-(image.size.height * 0.2) , image.size.width, (image.size.height * 0.2))
        let newText : NSString = text
        var style = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        style.alignment = NSTextAlignment.Center // center text
        var attrs = [NSFontAttributeName: UIFont.systemFontOfSize((image.size.height * 0.17)), NSForegroundColorAttributeName : UIColor.whiteColor(), NSParagraphStyleAttributeName : style]
        newText.drawInRect(CGRectIntegral(rect), withAttributes: attrs)

//end adding text

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }

    @IBAction func updatePicturePost(sender: AnyObject) { // post picture method
        let requestApi = NSURL(string: "https://api.twitter.com/1.1/account/update_profile_image.json")

        let picData = UIImagePNGRepresentation(self.profilePicImageView.image) // changes image to NSDATA
        let base64Image = picData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength) // turn image to base64 image

        let userRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.POST, URL: requestApi, parameters: ["image" : base64Image])

        userRequest.account = self.twitterAccount

        userRequest.performRequestWithHandler({ (response:NSData!, urlResponce:NSHTTPURLResponse!, error:NSError! ) -> Void in

            var error = NSErrorPointer()

            let responseDictonary = NSJSONSerialization.JSONObjectWithData(response, options: NSJSONReadingOptions.MutableLeaves, error: error) as! [String : AnyObject]

            if urlResponce.statusCode == 200 {
                var alertController = UIAlertController(title: "Picture Updated!", message: "Your profile picure was updated successfully!", preferredStyle: UIAlertControllerStyle.Alert)
                var alertAction = UIAlertAction(title: "Awesome", style: UIAlertActionStyle.Default, handler: nil)
                alertController.addAction(alertAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            } else{
                var errorAlertController = UIAlertController(title: "Error!", message: "Oops! Looks like your picture was not updated!", preferredStyle: UIAlertControllerStyle.Alert)
                var errorAlertAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil)
                errorAlertController.addAction(errorAlertAction)
                self.presentViewController(errorAlertController, animated: true, completion: nil)
            }

        })

    }
}
