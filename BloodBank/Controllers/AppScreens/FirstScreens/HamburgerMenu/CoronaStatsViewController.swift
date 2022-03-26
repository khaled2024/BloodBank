//
//  CoronaStatsViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 22/03/2022.
//

import UIKit

class CoronaStatsViewController: UIViewController{
    
    
    //MARK: - Outlets
    @IBOutlet weak var confirmedLbl: UILabel!
    @IBOutlet weak var recoveredLbl: UILabel!
    @IBOutlet weak var deathsLbl: UILabel!
    @IBOutlet weak var statsViewConfirmed: UIView!
    @IBOutlet weak var coronaview: UIView!
    @IBOutlet weak var statsViewRecoverd: UIView!
    @IBOutlet weak var statsViewDeath: UIView!
    @IBOutlet weak var countryConfirmedStats: UIView!
    @IBOutlet weak var countryRecoveredStats: UIView!
    @IBOutlet weak var countryDeathsStats: UIView!
    @IBOutlet weak var countryTF: UITextField!
    let navBar = NavigationBar()
    let customView = CustomView()
    private let CountryPicker = UIPickerView()
    
    let corona = CoronaStats(CountryArr:  ["Egypt","Ghana","China"])
    var coronaAnalysis = CoronaAnalysis(cases: 0, recovered: 0, deaths: 0)
    
    //MARK: - lifeCycles
    override  func viewDidLoad() {
        setUpPicker()
        self.getCoronaAnalysis()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setUpDesign()
        
    }
    //MARK: - private func
    private func getCoronaAnalysis(){
        ApiService.sharedService.getCoronaAnalysis { (coronaAnalysis: CoronaAnalysis?, error )in
            guard let coronaAnalysis = coronaAnalysis else {return}
            self.coronaAnalysis = coronaAnalysis
            DispatchQueue.main.async {
                self.confirmedLbl.text = "\(self.coronaAnalysis.cases?.formatUsingAbbrevation() ?? "")+"
                self.recoveredLbl.text = "\(self.coronaAnalysis.recovered?.formatUsingAbbrevation() ?? "")+"
                self.deathsLbl.text = "\(self.coronaAnalysis.deaths?.formatUsingAbbrevation() ?? "")+"
            }
        }
    }
    private func setUpPicker(){
        CountryPicker.delegate = self
        CountryPicker.dataSource = self
        countryTF.inputView = CountryPicker
    }
    private func setUpDesign(){
        navBar.setNavBar(myView: self, title: "", viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.white, forgroundTitle: UIColor.forgroundTitle, bacgroundView: UIColor.backgroundView)
        self.navigationController?.navigationBar.backgroundColor = .clear

        customView.customView(theView: statsViewConfirmed)
        customView.customView(theView: statsViewDeath)
        customView.customView(theView: statsViewRecoverd)
        customView.customView(theView: countryConfirmedStats)
        customView.customView(theView: countryRecoveredStats)
        customView.customView(theView: countryDeathsStats)
    }
}
//MARK: - Extension
extension CoronaStatsViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return corona.CountryArr.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryTF.text = corona.CountryArr[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return corona.CountryArr[row]
    }
}






//MARK: - comments

//        let currentLang = Locale.current.languageCode
//        if  currentLang == "en" {
//            coronaview.roundedCornerView(corners: [.bottomLeft ], radius: coronaview.frame.size.width/6)
//        }else{
//            coronaview.roundedCornerView(corners: [.bottomRight ], radius: coronaview.frame.size.width/6)
        //        }
