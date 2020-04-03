//
//  AppDelegate.swift
//  TestRxSwift
//
//  Created by Lee on 2020/04/01.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    
//    window?.rootViewController = UINavigationController(rootViewController: ListViewController())
    window?.rootViewController = CalculatorViewController()
    window?.makeKeyAndVisible()
    
    return true
  }

}

