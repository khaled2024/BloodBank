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
        title = "الاعدادات"
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9845134616, green: 0.9810839295, blue: 0.9719126821, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1) , .font: UIFont(name: "Almarai", size: 20)!]
        self.view.backgroundColor =  #colorLiteral(red: 0.9845134616, green: 0.9810839295, blue: 0.9719126821, alpha: 1)
        changeLangBtn.titleLabel?.text = "changeLanguage".Localized()
        changeLangBtn.titleLabel?.font = UIFont(name: "Almarai-Bold", size: 20)
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
        self.SuccessAlert(title: "the Language is changed ", message: "Please ReEnter the App", style: .default) { _ in
            exit(0)
        }
    }
}
