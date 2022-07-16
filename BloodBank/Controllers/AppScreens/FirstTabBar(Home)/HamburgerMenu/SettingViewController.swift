//
//  SettingViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 06/02/2022.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var darkModeLbl: UILabel!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var changeLangBtn: UIButton!
    @IBOutlet weak var settingSwitch: UISwitch!
    @IBOutlet weak var activateNotificationLbl: UILabel!
    let def = UserDefaults.standard
    let navBar = NavigationBar()
    let appDelegate = UIApplication.shared.windows.first
    override func viewDidLoad() {
        super.viewDidLoad()
        isNotificationOn()
        isDarkModeOn()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpDesign()
    }
    
    //MARK: - Private func
    private func setUpDesign(){
        navBar.setNavBar(myView: self, title: "Setting".Localized(), viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor, forgroundTitle: UIColor.forgroundTitle, bacgroundView: UIColor.backgroundView)
        self.activateNotificationLbl.text = "Activate Notification".Localized()
        self.darkModeLbl.text = "Dark mode".Localized()
        
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
                        self.showAlertWithSettingBtn(title: "Sorry", message: "Please turn on your Notification to get the lastest Notifications")
                    }
                    print("switch on")
                }
            }else if isNotificationOn == false{
                settingSwitch.isOn = false
                print("switch off")
            }
        }
    }
    func isDarkModeOn(){
        if #available(iOS 13.0, *){
            if let isDarkModeOn = def.object(forKey: "isDarkModeOn") as? Bool{
                if isDarkModeOn == true{
                    darkModeSwitch.isOn = true
                    self.def.set(true, forKey: "isDarkModeOn")
                    appDelegate?.overrideUserInterfaceStyle = .dark
                    return
                }
                darkModeSwitch.isOn = false
                self.def.set(false, forKey: "isDarkModeOn")
                appDelegate?.overrideUserInterfaceStyle = .light
                return
            }else{
                //
            }
        }
    }
    private func scaduleNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Blood Bank".Localized()
        content.subtitle = ""
        content.body = "notificationBody".Localized()
        content.sound = .default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(5), repeats: false)
        let request = UNNotificationRequest(identifier: "idNotification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    //MARK: - Actions
    @IBAction func darkModeSetting(_ sender: UISwitch) {
        if sender.isOn{
            sender.isOn = true
            self.def.set(true, forKey: "isDarkModeOn")
            isDarkModeOn()
        }else{
            sender.isOn = false
            self.def.set(false, forKey: "isDarkModeOn")
            appDelegate?.overrideUserInterfaceStyle = .light        }
    }
    @IBAction func settingSwitchTapped(_ sender: UISwitch) {
        if sender.isOn{
            sender.isOn = true
            self.def.set(true, forKey: "isNotificationOn")
            isNotificationOn()
        }else{
            sender.isOn = false
            self.def.set(false, forKey: "isNotificationOn")
            
        }
    }
    
    @IBAction func changeLangBtnTapped(_ sender: UIButton) {
        // فيه مشكله هنا عشان في اسكرينات او فيووز هتبقي فيها ايرور ف اللغه العربي ف سرش عليها (ازاي اعمل لوكاليزيشن بس فيه استثنائات ف التطبيق اسكرينات كده)
        let currentLang = Locale.current.languageCode
        print(currentLang!)
        let newLang = currentLang == "en" ? "ar" : "en"
        UserDefaults.standard.setValue([newLang], forKey: "AppleLanguages")
        print(newLang)
        self.showAlertWithCancleBtn(title: "Are you sure you want to change the Language of the Application to (\(newLang.uppercased()))", message: "", style: .default) { _
            in
            exit(0)
        }
    }
}
