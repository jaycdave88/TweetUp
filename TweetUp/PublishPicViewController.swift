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
        
        self.profilePicImageView.image = self.profileImage
    }

}
