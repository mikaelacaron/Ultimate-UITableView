//
//  AppDelegate.swift
//  ultimateTableView
//
//  Created by Mikaela Caron on 3/1/19.
//  Copyright © 2019 Mikaela Caron. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = AmiiboListVC()
        window?.makeKeyAndVisible()
        
        
        return true
    }
}

