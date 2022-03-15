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
    let def = UserDefaults.standard
    private let navigationManager = NavigationManager()
    private let storageManager = StorageManager()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // keyboard touch out side
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        //root
        // here when we wanna to reset the onboarding screen again
//        storageManager.resetOnboardingSeen()
        setRoot()

        UNUserNotificationCenter.current().delegate = self
        return true
    }
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    //MARK: - functions
    func setRoot(){
        
        if let isLoggedIn = def.object(forKey: "isLoggedIn")as? Bool{
            if isLoggedIn {
//                TabBarScreen()
                navigationManager.show(screen: .tapBarController, inController: TabBarController())

            }else {
                goTOHomeScreen()
            }
        }
    }
     func TabBarScreen(){
        let sb = UIStoryboard(name:"Main", bundle: nil)
        let tabBarScreen = sb.instantiateViewController(withIdentifier: "TabBarController")as! TabBarController
        let navController = UINavigationController(rootViewController: tabBarScreen)
        self.window?.rootViewController = navController
         
    }
   func goTOHomeScreen(){
        let sb = UIStoryboard(name:"Main", bundle: nil)
        let HomeNC = sb.instantiateViewController(withIdentifier: "HomeNC") as! HomeNCViewController
//        let navController = UINavigationController(rootViewController: HomeNC)
        self.window?.rootViewController = HomeNC
    }
   
    
}
//MARK: - Extension {UNUserNotificationCenterDelegate}
extension AppDelegate: UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner])
    }
    
    
}
