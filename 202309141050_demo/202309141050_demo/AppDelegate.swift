//
//  AppDelegate.swift
//  202309141050_demo
//
//  Created by ChildhoodAndy on 2023/9/14.
//

import UIKit
import os

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "UI")
        let email = "dabing1022@gmail.com"

        logger.log("email private: \(email, privacy: .private)")
        logger.warning("email public: \(email, privacy: .public)")
        
        logger.error("email auto: \(email, privacy: .auto)")
        logger.fault("email sensitive mask: \(email, privacy: .sensitive)")
        
        

        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

