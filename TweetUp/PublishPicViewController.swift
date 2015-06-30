//
//  PublishPicViewController.swift
//  TweetUp
//
//  Created by DEV MODE on 6/29/15.
//  Copyright (c) 2015 DEV MODE. All rights reserved.
//

import UIKit

class PublishPicViewController: UIViewController {

    var profileImage : UIImage? = nil

    var imageText = ""

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

}
