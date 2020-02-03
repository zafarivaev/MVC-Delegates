//
//  AppDelegate.swift
//  MVC-Realm
//
//  Created by Zafar on 1/28/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let controller = ItemsViewController()
        let view = ItemsView()
        let model = ItemsModel()
               
        controller.itemsView = view
        controller.itemsView?.controller = controller
        controller.itemsModel = model
        controller.itemsModel?.controller = controller
        
        window = UIWindow()
        window?.rootViewController = UINavigationController(rootViewController: controller)
        window?.makeKeyAndVisible()
        
        return true
    }

}

