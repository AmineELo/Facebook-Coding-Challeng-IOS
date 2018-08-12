//
//  AppDelegate.swift
//  Facebook Coding Challenge
//
//  Created by Amine Elouattar on 8/3/18.
//  Copyright © 2018 Amine Elouattar. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FacebookCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Init the Facebook SDK
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions:launchOptions)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        //Check if the user logged in
        //if yes then make the album grid VC the rootVC
        //if no then make the Login VC the rootVC
        if let _ = AccessToken.current{
            let mainScreen = storyBoard.instantiateViewController(withIdentifier: "albumGridNavigationController")
            self.window?.rootViewController = mainScreen

        }else{
            let loginScreen = storyBoard.instantiateViewController(withIdentifier: "loginViewController")
            self.window?.rootViewController = loginScreen
        }
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
    }



}

