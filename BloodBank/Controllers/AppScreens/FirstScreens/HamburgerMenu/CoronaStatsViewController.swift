//
//  CoronaStatsViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 22/03/2022.
//

import UIKit

class CoronaStatsViewController: UIViewController{
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var staySafeLbl: UILabel!
    @IBOutlet weak var covid19Lbl: UILabel!
    @IBOutlet weak var globalUpdateLbl: UILabel!

    
    @IBOutlet weak var worldDeathsLbl: UILabel!
    @IBOutlet weak var worldRecoveredLbl: UILabel!
    @IBOutlet weak var worldCasesLbl: UILabel!
     @IBOutlet weak var confirmedLbl: UILabel!
     @IBOutlet weak var recoveredLbl: UILabel!
     @IBOutlet weak var deathsLbl: UILabel!
    
    
    @IBOutlet weak var countryDeathsLbl: UILabel!
    @IBOutlet weak var countryRecoveredLbl: UILabel!
    @IBOutlet weak var countryCasesLbl: UILabel!
    
   
    @IBOutlet weak var contryCases: UILabel!
    @IBOutlet weak var recoveredCountry: UILabel!
    @IBOutlet weak var deathsCountry: UILabel!
    
    
    
    @IBOutlet weak var populationLbl: UILabel!
    
    @IBOutlet weak var populationLblNum: UILabel!
    
    @IBOutlet weak var criticalLbl: UILabel!
    
    @IBOutlet weak var criticalNum: UILabel!
    
    @IBOutlet weak var activeLbl: UILabel!
    
    @IBOutlet weak var activeLblNum: UILabel!
    
    
    @IBOutlet weak var countryActiveView: UIView!
    @IBOutlet weak var countrycriticalView: UIView!
    @IBOutlet weak var countryPopulationView: UIView!
    @IBOutlet weak var statsViewConfirmed: UIView!
    @IBOutlet weak var coronaview: UIView!
    @IBOutlet weak var statsViewRecoverd: UIView!
    @IBOutlet weak var statsViewDeath: UIView!
    @IBOutlet weak var countryConfirmedStats: UIView!
    @IBOutlet weak var countryRecoveredStats: UIView!
    @IBOutlet weak var countryDeathsStats: UIView!
    
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var countryImage: UIImageView!
    
    let navBar = NavigationBar()
    let customView = CustomView()
    private let CountryPicker = UIPickerView()
    var countryArr: [String] = []
    var countryStatsArr: [CountryStats] = []
    var coronaAnalysis = CoronaAnalysis(cases: 0, recovered: 0, deaths: 0)
    
    //MARK: - lifeCycles
    override  func viewDidLoad() {
        setUpPicker()
        self.getCoronaAnalysis()
        self.getCountryStats()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setUpDesign()
        
    }
    //MARK: - private func
    private func getCountryStats(){
        ApiService.sharedService.getCountryInfo { countryStats, error in
            guard let countryStats = countryStats else{return}
            self.countryStatsArr = countryStats
            DispatchQueue.main.async {
                for country in countryStats{
                    self.countryArr.append(country.country!)
                }
            }
        }
    }
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
        customView.customView(theView: countryPopulationView)
        customView.customView(theView: countrycriticalView)
        customView.customView(theView: countryActiveView)
        globalUpdateLbl.text = "global Update".Localized()
        worldCasesLbl.text = "Cases".Localized()
        worldRecoveredLbl.text = "Recovered".Localized()
        worldDeathsLbl.text = "Deaths".Localized()
        
        
        
        countryCasesLbl.text = "Cases".Localized()
        countryRecoveredLbl.text = "Recovered".Localized()
        countryDeathsLbl.text = "Deaths".Localized()
        populationLbl.text = "population".Localized()
        criticalLbl.text = "Critical".Localized()
        activeLbl.text = "Active".Localized()
        
        
    }
    private func setCountryData(_ row: Int){
        DispatchQueue.main.async {
            
            self.countryTF.text = self.countryArr[row]
            guard let myCountry = self.countryStatsArr[row].countryInfo  else{return}
            guard let imageUrl = myCountry.flag else{return}
            self.countryImage.load(urlString: imageUrl)
            self.contryCases.text = "\(self.countryStatsArr[row].cases?.formatUsingAbbrevation() ?? "")+"
            self.recoveredCountry.text = "\(self.countryStatsArr[row].recovered?.formatUsingAbbrevation() ?? "")+"
            self.deathsCountry.text = "\(self.countryStatsArr[row].deaths?.formatUsingAbbrevation() ?? "")+"
            
            self.populationLblNum.text = "\(self.countryStatsArr[row].population?.formatUsingAbbrevation() ?? "")+"
            self.criticalNum.text = "\(self.countryStatsArr[row].critical?.formatUsingAbbrevation() ?? "")+"
            self.activeLblNum.text = "\(self.countryStatsArr[row].active?.formatUsingAbbrevation() ?? "")+"
        }
        
    }
}
//MARK: - Extension
extension CoronaStatsViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryArr.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.setCountryData(row)
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryArr[row]
    }
}

//MARK: - comments

//        let currentLang = Locale.current.languageCode
//        if  currentLang == "en" {
//            coronaview.roundedCornerView(corners: [.bottomLeft ], radius: coronaview.frame.size.width/6)
//        }else{
//            coronaview.roundedCornerView(corners: [.bottomRight ], radius: coronaview.frame.size.width/6)
//        }