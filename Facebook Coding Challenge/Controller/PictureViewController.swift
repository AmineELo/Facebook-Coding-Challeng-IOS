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
        configureAlbumGrid()
        getPictures()
    }
    
    func configureAlbumGrid(){
        pictureCollectionView.delegate = self
        pictureCollectionView.dataSource = self
        // make the cell width equal to half the screen (-10 for the spacing)
        let width = (view.frame.size.width - 10) / 2
        let layout = pictureCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }
    
    func getPictures(){
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/" + albumId + "/photos?fields=picture")) { httpResponse, result in
            switch result {
            case .success(let response):
                self.extractPictures(response: response)
                
            case .failed(let error):
                print("Graph Request Failed: \(error)")
            }
        }
        connection.start()
    }
    
    func extractPictures(response: GraphRequest.Response){
        if let responseDictionary = response.dictionaryValue{
            if let data: NSArray = responseDictionary["data"] as? NSArray{
                for  i in 0..<data.count {
                    appendPicture(array: data, index: i)
                }
                pictureCollectionView.reloadData()
            }
        }
    }
    
    func appendPicture(array: NSArray, index: Int){
        //Extract the an object from the data array
        let valueDict : NSDictionary = array[index] as! NSDictionary
        
        let id = valueDict.object(forKey: "id") as! String
        let pictureUrl = valueDict.object(forKey: "picture") as! String
        // append data to the dataset
        let picture = Picture()
        picture.pictureId = id
        picture.pictureUrl = pictureUrl
        
        pictures.append(picture)
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
