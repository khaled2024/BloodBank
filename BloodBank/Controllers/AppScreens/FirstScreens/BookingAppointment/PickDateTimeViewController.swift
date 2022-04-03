//
//  PickDateTimeViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 08/03/2022.
//

import UIKit

class PickDateTimeViewController: UIViewController {
    
    @IBOutlet weak var bloodTypeTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var confirmDateBtn: UIButton!
    let navBar = NavigationBar()
    let bloodTypePickerView = UIPickerView()
    let arrOfBloodType = Arrays.arrayOfBloodType

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDesign()
        bloodTypeTextField.inputView = bloodTypePickerView
        bloodTypePickerView.delegate = self
        bloodTypePickerView.dataSource = self
        datePicker.preferredDatePickerStyle = .inline
        datePicker.date = Date()
        datePicker.locale = .current
        datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        confirmDateBtn.backgroundColor =  #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
    //MARK: - private functions
    private func setUpDesign(){
        title = "حدد الوقت والتاريخ"
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1) , .font: UIFont(name: "Almarai-Bold", size: 20)!]
        self.view.backgroundColor =  #colorLiteral(red: 0.9845134616, green: 0.9810839295, blue: 0.9719126821, alpha: 1)
        navigationItem.backButtonTitle = ""
        navigationItem.backBarButtonItem?.isEnabled = false
//        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false

    }
    //MARK: - Actions
    private func openSheet(){
        let sheetPresentationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SheetViewController")as! SheetViewController
        self.present(sheetPresentationController, animated: true, completion: nil)
    }
    @objc func dateSelected(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .short
        let date = dateFormatter.string(from: datePicker.date)
        dateTimeLabel.text = date
        self.confirmDateBtn.backgroundColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
        
    }
    
    @IBAction func confirmDateBtnTapped(_ sender: UIButton) {
        if let dateLbl = dateTimeLabel.text , !dateLbl.isEmpty{
            openSheet()
        }else{
            self.confirmDateBtn.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
    }
}


extension PickDateTimeViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrOfBloodType.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrOfBloodType[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        bloodTypeTextField.text = arrOfBloodType[row]
    }
}
//
//DispatchQueue.main.asyncAfter(deadline: .now()+1) {
//
//}
