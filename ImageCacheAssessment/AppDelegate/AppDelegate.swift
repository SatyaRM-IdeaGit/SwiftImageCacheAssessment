//
//  AppDelegate.swift
//  ImageCacheAssessment
//
//  Created by SatyaRanjan Mohapatra on 28/04/24.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		self.window = UIWindow(frame: UIScreen.main.bounds)
		self.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PrimaryVC")
		self.window?.makeKeyAndVisible()
		
		return true
	}
}

