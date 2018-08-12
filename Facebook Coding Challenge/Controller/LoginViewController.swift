//
//  ViewController.swift
//  Facebook Coding Challenge
//
//  Created by Amine Elouattar on 8/3/18.
//  Copyright © 2018 Amine Elouattar. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginWithFacebook(_ sender: Any) {
        loginWithFacebook()
    }
    
    func loginWithFacebook(){
        let loginManager = LoginManager()
        
        loginManager.logIn(readPermissions: [.publicProfile], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(_, _, _):
                print("Success")
                self.showAlbumGridVC()
            }
        }
    }
    
    //This method is a workaround for the active bug mentionned here https://github.com/facebook/facebook-sdk-swift/issues/201
    //When the LoginManager callback returns, then the presentedViewController on the current LoginViewController is still
    //SFAuthenticationViewController.
    //This forces me to add a delay before I can continue working with the view stack.
    func showAlbumGridVC(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.performSegue(withIdentifier: "goToAlbumGrid", sender: self)
        })
    }
    
    
}

