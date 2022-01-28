//
//  AppDelegate.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 15/12/2021.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    private let storageManager = StorageManager()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // keyboard touch out side
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        // here when we wanna to reset the onboarding screen again
//        storageManager.resetOnboardingSeen()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }

}







//
//func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//
//    if(UserDefaults.standard.bool(forKey: "notFirstInApp") == false){
//        UserDefaults.standard.set(true, forKey: "notFirstInApp")
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let OnBoardingVC = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController")
//        self.window?.rootViewController = OnBoardingVC
//        self.window?.makeKeyAndVisible()
//    }else{
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let HomeNC = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
//        self.window?.rootViewController = HomeNC
//    }
//    return true
//}
