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

class AlbumsGridViewController: UIViewController {

    @IBOutlet weak var albumCollectionView: UICollectionView!
    
    var albums = [String]()
    
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
        // make the cell width equal to half the screen (-20 for the spacing)
        let width = (view.frame.size.width - 20) / 2
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
                    let valueDict : NSDictionary = data[i] as! NSDictionary
                    let count = valueDict.object(forKey: "count") as! NSNumber
                    let id = valueDict.object(forKey: "name") as! String
                    let pictureUrl = ((valueDict.object(forKey: "picture") as! NSDictionary)
                        .object(forKey: "data") as! NSDictionary)
                        .object(forKey: "url") as! String
                    print(count)
                    print(id)
                    print(pictureUrl)
                }
            }
        }
    }
}

extension AlbumsGridViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
}
