//
//  AlbumsGridViewController.swift
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

class AlbumsGridViewController: UIViewController {

    @IBOutlet weak var albumCollectionView: UICollectionView!
    
    var albums = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureAlbumGrid()
        getUserAlbums()
    }

    @IBAction func logoutPressed(_ sender: Any) {
        logout()
    }
    
    func configureAlbumGrid(){
        albumCollectionView.delegate = self
        albumCollectionView.dataSource = self
        // make the cell width equal to half the screen (-10 for the spacing)
        let width = (view.frame.size.width - 10) / 2
        let layout = albumCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }
    
    func logout(){
        let loginManager = LoginManager()
        loginManager.logOut()
        changeRootViewControllerToLogin()
    }
    
    func changeRootViewControllerToLogin(){
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        guard let rootViewController = window.rootViewController else {
            return
        }
        
        let storyboard = self.storyboard
        let vc = storyboard?.instantiateViewController(withIdentifier: "loginViewController")
        vc?.view.frame = rootViewController.view.frame
        vc?.view.layoutIfNeeded()
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = vc
        })
    }
    
    func getUserAlbums(){
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/me/albums?fields=cover_photo,picture,name,count")) { httpResponse, result in
            switch result {
            case .success(let response):
                //print("Graph Request Succeeded: \(response)")
                self.extractAlbums(response: response)
                
            case .failed(let error):
                print("Graph Request Failed: \(error)")
            }
        }
        connection.start()
    }
    
    func extractAlbums(response: GraphRequest.Response){
        if let responseDictionary = response.dictionaryValue{
            if let data: NSArray = responseDictionary["data"] as? NSArray{
                for  i in 0..<data.count {
                    appendAlbum(array: data, index: i)
                }
                albumCollectionView.reloadData()
            }
        }
    }
    
    func appendAlbum(array: NSArray, index: Int){
        //Extract the an object from the data array
        let valueDict : NSDictionary = array[index] as! NSDictionary
        
        let id = valueDict.object(forKey: "id") as! String
        let count = valueDict.object(forKey: "count") as! NSNumber
        let name = valueDict.object(forKey: "name") as! String
        let pictureUrl = ((valueDict.object(forKey: "picture") as! NSDictionary)
            .object(forKey: "data") as! NSDictionary)
            .object(forKey: "url") as! String
        // append data to the dataset
        let album = Album()
        album.albumName = name
        album.albumCoverUrl = pictureUrl
        album.albumCount = String(count as! Int)
        album.albumId = id
        
        albums.append(album)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPictureGrid" {
            if let destinationVC = segue.destination as? PictureViewController,
                let index = sender as? IndexPath{
                destinationVC.albumId = albums[index.row].albumId
            }
        }
    }
}

extension AlbumsGridViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = albumCollectionView.dequeueReusableCell(withReuseIdentifier: "albumCollectionCell", for: indexPath)
        if let nameLabel = cell.viewWithTag(10) as? UILabel{
            nameLabel.text = albums[indexPath.row].albumName
        }
        
        //Image downloading
        if let coverImage = cell.viewWithTag(20) as? UIImageView{
            let url = URL(string: albums[indexPath.row].albumCoverUrl)
            coverImage.af_setImage(withURL: url!)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToPictureGrid", sender: indexPath)
    }
}
