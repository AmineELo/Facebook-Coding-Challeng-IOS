//
//  FullScreenViewController.swift
//  Facebook Coding Challenge
//
//  Created by Amine Elouattar on 8/12/18.
//  Copyright © 2018 Amine Elouattar. All rights reserved.
//

import UIKit

class FullScreenViewController: UIViewController {

    @IBOutlet weak var fullScreenImage: UIImageView!
    
    var pictureUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        downloadPicture()
    }
    
    func downloadPicture(){
        let url = URL(string: pictureUrl)
        fullScreenImage.af_setImage(withURL: url!)
    }

}
