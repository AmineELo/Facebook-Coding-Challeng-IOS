//
//  FullScreenViewController.swift
//  Facebook Coding Challenge
//
//  Created by Amine Elouattar on 8/12/18.
//  Copyright © 2018 Amine Elouattar. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import Alamofire
import AlamofireImage

class FullScreenViewController: UIViewController {

    @IBOutlet weak var fullScreenImage: UIImageView!
    
    var pictureId = ""
    var pictureUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //downloadPicture()
        downloadPicture1()
    }
    
    func downloadPicture1() {
        let url = URL(string: pictureUrl)
        let placeholderImage = UIImage(named: "placeholder")
        fullScreenImage.af_setImage(withURL: url!, placeholderImage: placeholderImage)
    }

}
