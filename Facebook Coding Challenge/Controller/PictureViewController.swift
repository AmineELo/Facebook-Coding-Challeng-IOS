//
//  PictureViewController.swift
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

class PictureViewController: UIViewController {
    
    @IBOutlet weak var pictureCollectionView: UICollectionView!
    var albumId = ""
    
    var pictures = [Picture]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(albumId)
    }
}

extension PictureViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        return UICollectionViewCell()
    }
}
