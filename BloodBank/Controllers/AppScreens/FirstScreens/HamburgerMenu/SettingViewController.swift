//
//  SettingViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 06/02/2022.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var changeLangBtn: UIButton!
    
    @IBOutlet weak var settingSwitch: UISwitch!
    let def = UserDefaults.standard
    let navBar = NavigationBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        isNotificationOn()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpDesign()
    }
    
    //MARK: - Private func
    
    private func setUpDesign(){
        navBar.setNavBar(myView: self, title: "Setting".Localized(), viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor, forgroundTitle: UIColor.forgroundTitle, bacgroundView: UIColor.backgroundView)
    }
    func isNotificationOn(){
        if let isNotificationOn = def.object(forKey: "isNotificationOn")as? Bool{
            if isNotificationOn == true{
                settingSwitch.isOn = true
                self.def.set(true, forKey: "isNotificationOn")
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { granted, error in
                    if granted{
                        DispatchQueue.main.async {
                            print("granted")
                            self.scaduleNotification()
                        }
                    }else{
                        print("denied error")
                        self.showAlertWithAction(title: "Sorry", message: "Please turn on your Notification to get the lastest Notifications")
                    }
                    print("switch on")
                }
            }else if isNotificationOn == false{
                settingSwitch.isOn = false
                print("switch off")
            }
        }
    }
    private func scaduleNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Blood Bank"
        content.subtitle = "Blood Bank Subtitle"
        content.body = "التطبيق بحاجه اليك لكي تكون بطلاً في حياه شخص ما"
        content.sound = .default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(5), repeats: false)
        let request = UNNotificationRequest(identifier: "idNotification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    //MARK: - Actions
    @IBAction func settingSwitchTapped(_ sender: UISwitch) {
        if sender.isOn{
            sender.isOn = true
            self.def.set(true, forKey: "isNotificationOn")
            isNotificationOn()
        }else{
            sender.isOn = false
            self.def.set(false, forKey: "isNotificationOn")
//            isNotificationOn()
        }
    }
   
    @IBAction func changeLangBtnTapped(_ sender: UIButton) {
        // فيه مشكله هنا عشان في اسكرينات او فيووز هتبقي فيها ايرور ف اللغه العربي ف سرش عليها (ازاي اعمل لوكاليزيشن بس فيه استثنائات ف التطبيق اسكرينات كده)
        let currentLang = Locale.current.languageCode
        print(currentLang!)
        let newLang = currentLang == "en" ? "ar" : "en"
        UserDefaults.standard.setValue([newLang], forKey: "AppleLanguages")
        print(newLang)
        self.myAlert(title: "Are you sure you want to change the Language of the Application to (\(newLang))", message: "", style: .default) { _
            in
            exit(0)
        }
    }
}
