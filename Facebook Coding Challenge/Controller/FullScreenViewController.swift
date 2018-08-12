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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        downloadPicture()
    }

    
    func downloadPicture(){
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/" + pictureId + "/?fields=images")) { httpResponse, result in
            switch result {
            case .success(let response):
                self.extractPicture(response: response)
                
            case .failed(let error):
                print("Graph Request Failed: \(error)")
            }
        }
        connection.start()
    }
    
    func extractPicture(response: GraphRequest.Response){
        if let responseDictionary = response.dictionaryValue{
            if let images: NSArray = responseDictionary["images"] as? NSArray{
                let pictureHD = images[0] as! NSDictionary
                let pictureUrl = pictureHD.value(forKey: "source") as! String
                
                let url = URL(string: pictureUrl)
                fullScreenImage.af_setImage(withURL: url!)
            }
        }
    }

}
