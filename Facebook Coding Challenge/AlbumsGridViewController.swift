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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logoutPressed(_ sender: Any) {
        logout()
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
}
