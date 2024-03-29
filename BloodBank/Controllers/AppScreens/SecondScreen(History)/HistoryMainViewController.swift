//
//  AppointmentMainViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 23/02/2022.
//

import UIKit

class HistoryMainViewController: UIViewController {
    //MARK: - outlets
    @IBOutlet weak var noDataImageView: UIImageView!
    @IBOutlet weak var segmentControll: UISegmentedControl!
    @IBOutlet weak var HistorytableView: UITableView!
    //MARK: - Variabels
    let navBar = NavigationBar()
    var segmentSender = 0
    var p_ssn: String?
    var vaccineId: String = ""
    var placeId: String = ""
    var vaccineName: String = ""
    var placeName: String = ""
    var placeNameOfPurchaseOrder = ""
    var timeOfLastDonate: String = ""
    var bloodTypeName = ""
    var bloodId = ""
    var testPlaceVaccine: [String] = []
    var arrOfTimesOfDonation: [String] = []
    var dicOfBloodTypes: [String:String] = [:]
    var dicOfPlaceNames: [String:String] = [:]
    var dicOfPlaceNamesOfVaccine: [String:String] = [:]
    var arrOfNamesOfPlaces: [String] = []
    //quick request
    var arrOfQuickRequest: [QuickRequestData] = [QuickRequestData]()
    var arrOfPrivateQuickRequest: [QuickRequestData] = [QuickRequestData]()
    //vaccine
    var arrOfVaccine: [OrderVaccineData] = [OrderVaccineData]()
    var arrOfPrivateVaccine: [OrderVaccineData] = [OrderVaccineData]()
    //donation
    var arrOfPrivateDonations: [LastDonateData] = [LastDonateData]()
    // Last donation
    var arrOfPrivatePurchaseOrder: [PurchaseOrderData] = [PurchaseOrderData]()
    //refresh Controll
    let def = UserDefaults.standard
    var refreshControll = UIRefreshControl()
    let currentLang = Locale.current.languageCode
    let reachability = try! Reachability()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibCells()
        if let user = def.object(forKey: "userInfo")as? [String]{
            self.p_ssn = user[0]
            print(self.p_ssn ?? "")
        }
        refreshControll.tintColor = .systemPink
        refreshControll.addTarget(self, action: #selector(refreshTapped), for: .valueChanged)
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkingInternetConnection()
        self.setUpDesign()
        self.HistorytableView.reloadData()
    }
    override func viewDidLayoutSubviews() {
        self.HistorytableView.addSubview(refreshControll)
        self.myQuickRequests()
    }
    //MARK: - private func
    private func checkingInternetConnection(){
        self.reachability.whenReachable = { reachability in
            if reachability.connection == .wifi{
                print("Reachable to wifi")
                self.noDataImageView.isHidden = true
                self.HistorytableView.isHidden = false
                //func
                self.getAllBloodNames()
                self.getPlaceNamesForPurchaseBlood()
                self.getPlaceNameOfOrderVaccine()
                self.myVaccine()
                self.getPlaceNameVaccine()
                self.myQuickRequests()
                self.getPurchase_order()
                self.getBlood()
                self.getMyLastDonate()
            }else{
                print("Not Reachable to wifi")
                self.noDataImageView.isHidden = false
                self.HistorytableView.isHidden = true
            }
        }
        self.reachability.whenUnreachable = { _ in
            print("not reachable")
            self.showAlertWithSettingBtn(title:"No Internet".Localized(), message: "Error Connection".Localized())
            self.noDataImageView.isHidden = false
            self.HistorytableView.isHidden = true
            self.arrOfQuickRequest = []
            self.arrOfPrivateQuickRequest = []
            self.arrOfPrivateVaccine = []
            self.arrOfPrivateDonations = []
            self.arrOfPrivatePurchaseOrder = []
        }
        do {
            try reachability.startNotifier()
        } catch  {
            print("Unreachable to startNotifier")
        }
    }
    @objc func refreshTapped(){
        self.testPlaceVaccine.removeAll()
        
        myQuickRequests()
        getAllBloodNames()
        getPlaceNamesForPurchaseBlood()
        getPlaceNameOfOrderVaccine()
        getPlaceNameVaccine()
        getPurchase_order()
        
        self.myVaccine()
        self.getVaccineInfo()
        
       
        self.HistorytableView.reloadData()
        self.refreshControll.endRefreshing()

    }
    private func setUpDesign(){
        if currentLang == "en"{
            segmentControll.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Almarai-Bold", size: 9)!], for: .normal)
        }else{
            segmentControll.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Almarai-Bold", size: 14)!], for: .normal)
        }
        segmentControll.setTitle("Donation Requests".Localized(), forSegmentAt: 0)
        segmentControll.setTitle("Vaccine Requests".Localized(), forSegmentAt: 1)
        segmentControll.setTitle("Blood Orders".Localized(), forSegmentAt: 2)
        segmentControll.setTitle("Last Donation".Localized(), forSegmentAt: 3)
       
    }
    private func registerNibCells(){
        HistorytableView.register(UINib(nibName: "privateRequestCell", bundle: nil), forCellReuseIdentifier: "privateRequestCell")
        HistorytableView.register(UINib(nibName: "RequestsTableViewCell", bundle: nil), forCellReuseIdentifier: "Requestscell")
        HistorytableView.register(UINib(nibName: "HistoryVaccineCell", bundle: nibBundle), forCellReuseIdentifier: "HistoryVaccineCell")
        HistorytableView.register(UINib(nibName: "BloodOrderCell", bundle: nil), forCellReuseIdentifier: "BloodOrderCell")
        HistorytableView.register(UINib(nibName: "LastDonateHistoryCell", bundle: nil), forCellReuseIdentifier: "LastDonateHistoryCell")
        HistorytableView.register(UINib(nibName: "AcceptHistoryVaccineCell", bundle: nil), forCellReuseIdentifier: "AcceptHistoryVaccineCell")
        HistorytableView.register(UINib(nibName: "AcceptOrderBloodCell", bundle: nil), forCellReuseIdentifier: "AcceptOrderBloodCell")
        self.noDataImageView.isHidden = true
    }
    private func setUpSegment(){
        let segmentIndex = self.segmentControll.selectedSegmentIndex
        switch segmentIndex{
        case 0 :
            if self.arrOfPrivateQuickRequest.count == 0 {
                self.HistorytableView.isHidden = true
                self.noDataImageView.isHidden = false
            }else{
                self.HistorytableView.isHidden = false
                self.noDataImageView.isHidden = true
                print(segmentIndex)
                self.segmentSender = segmentIndex
                HistorytableView.reloadData()
            }
        case 1 :
            if self.arrOfPrivateVaccine.count == 0 {
                self.HistorytableView.isHidden = true
                self.noDataImageView.isHidden = false
            }else{
                self.HistorytableView.isHidden = false
                self.noDataImageView.isHidden = true
                print(segmentIndex)
                self.segmentSender = segmentIndex
                HistorytableView.reloadData()
            }
        case 2 :
            if self.arrOfPrivatePurchaseOrder.count == 0{
                self.HistorytableView.isHidden = true
                self.noDataImageView.isHidden = false
            }else{
                self.HistorytableView.isHidden = false
                self.noDataImageView.isHidden = true
                print(segmentIndex)
                self.segmentSender = segmentIndex
                HistorytableView.reloadData()
            }
        case 3 :
            if self.arrOfPrivateDonations.count == 0 {
                self.HistorytableView.isHidden = true
                self.noDataImageView.isHidden = false
            }else{
                self.HistorytableView.isHidden = false
                self.noDataImageView.isHidden = true
                print(segmentIndex)
                self.segmentSender = segmentIndex
                HistorytableView.reloadData()
            }
        default:
            break
        }
    }
    // put data from api
    // my quick request
    private func myQuickRequests(){
        DispatchQueue.main.async {
            ApiService.sharedService.allQuickRequests { error, request in
                self.arrOfPrivateQuickRequest = []
                if let error = error {
                    print(error.localizedDescription)
                    self.showNormalAlert(title: "للاسف", message: "لا يمكن الاتصال بالخادم:(")
                    self.HistorytableView.isHidden = true
                    self.noDataImageView.image = UIImage(named: "someThinfWrong2")
                    self.noDataImageView.isHidden = false
                }else if let request = request {
                    self.arrOfQuickRequest = request
                    print(self.arrOfQuickRequest)
                    if self.arrOfQuickRequest.count == 0{
                        self.showNormalAlert(title: "للاسف", message: "لا يوجد طلبات  لعرضها:(")
                        self.HistorytableView.isHidden = true
                        self.noDataImageView.isHidden = false
                        self.noDataImageView.image = UIImage(named: "emptyPage-2")
                    }else{
                        self.HistorytableView.isHidden = false
                        self.noDataImageView.isHidden = true
                        for request in self.arrOfQuickRequest {
                            if  self.p_ssn == request.p_ssn{
                                self.arrOfPrivateQuickRequest.append(request)
                                print("my quick request arr:\(self.arrOfPrivateQuickRequest)")
                            }
                            self.HistorytableView.reloadData()
                        }
                    }
                }
                self.myVaccine()
                self.getPlaceNameVaccine()
                self.getPlaceNameOfOrderVaccine()
                self.getVaccineInfo()
            }
        }
    }
    // my vaccine order
    private func myVaccine(){
        DispatchQueue.main.async {
            ApiService.sharedService.allOrderVaccines { error, orderVaccine in
                self.arrOfPrivateVaccine = []
                if let error = error {
                    print(error.localizedDescription)
                }else if let orderVaccine = orderVaccine {
                    self.arrOfVaccine = orderVaccine
                    print(self.arrOfVaccine)
                    for orderVaccine in self.arrOfVaccine {
                        if  self.p_ssn == orderVaccine.p_ssn{
                            self.arrOfPrivateVaccine.append(orderVaccine)
                            self.vaccineId = orderVaccine.vaccine_id
                            self.placeId = orderVaccine.delivered_place
                            print("vaccine id : \(self.vaccineId ),place id :\( self.placeId)")
                            self.testPlaceVaccine.append(orderVaccine.delivered_place)
                        }else{
                          print("failed to get private vaccine arr")
                        }
                    }
                    print("my vaccine arr:\(self.arrOfPrivateVaccine)")
                    self.HistorytableView.reloadData()
                    print("test arr : \(self.testPlaceVaccine)")
                }
            }
        }
    }
    private func getVaccineInfo(){
        DispatchQueue.main.async {
            ApiService.sharedService.getAllVaccines { error, vaccine in
                if let error = error {
                    print(error.localizedDescription)
                }else if let vaccine = vaccine {
                    for vaccine in vaccine {
                        if self.vaccineId == vaccine.vaccine_id{
                            self.vaccineName = vaccine.trade_name
                            print(vaccine.trade_name)
                            print(self.vaccineName)
                        }else{
                            print("error in vaccine name")
                        }
                    }
                }
            }
        }
    }
    private func getPlaceNameOfOrderVaccine(){
        DispatchQueue.main.async {
            ApiService.sharedService.getDonatePlace { error, places in
                if let error = error {
                    print(error.localizedDescription)
                }else if let places = places {
                    for place in places {
                        if self.placeId == place.id{
                            self.placeName = place.place_name
                            self.placeNameOfPurchaseOrder = place.place_name
                            print(self.placeName)
                            print(self.placeNameOfPurchaseOrder)
                            self.dicOfPlaceNamesOfVaccine[place.id] = place.place_name
                        }else{
                            print("error in vaccine place name")
                        }
                    }
                    print("dicOfPlaceNamesOfVaccine: \(self.dicOfPlaceNamesOfVaccine)")
                   
                }
            }
        }
    }
    private func getPlaceNameVaccine(){
        ApiService.sharedService.getAllVaccines { error, vaccine in
            if let error = error {
                print(error)
            }else if let vaccine = vaccine {
                for vaccine in vaccine {
                    for placeId in self.testPlaceVaccine{
                        if placeId == vaccine.vaccine_place_id{
                            self.arrOfNamesOfPlaces.append(vaccine.hospital_name)
                        }
                    }
                    break
                }
                print("arr of hospitals names : \(self.arrOfNamesOfPlaces)")
            }
        }
    }
    // blood
    private func getPlaceNamesForPurchaseBlood(){
        ApiService.sharedService.getAllBloodInfo { error, blood in
            if let error = error {
                print(error.localizedDescription)
            }else if let blood = blood {
                for blood in blood {
                    self.dicOfPlaceNames[blood.hospital_id] = blood.hospital_name
                }
                print(self.dicOfPlaceNames)
            }
        }
    }
    // my last donate
    private func getMyLastDonate(){
        DispatchQueue.main.async {
            ApiService.sharedService.myLastDonate { error, lastDonate in
                if let error = error {
                    print(error.localizedDescription)
                }else if let lastDonate = lastDonate {
                    for lastDonate in lastDonate {
                        if self.p_ssn  == lastDonate.p_ssn{
                            self.arrOfPrivateDonations.append(lastDonate)
                            self.timeOfLastDonate = lastDonate.time
                            self.arrOfTimesOfDonation.append(lastDonate.time)
                            
                            print(self.timeOfLastDonate)
                        }else{
                           
                        }
                        self.HistorytableView.reloadData()
                    }
                    print(self.arrOfTimesOfDonation)
                }
                
            }
        }
    }
    // buy blood
    private func getPurchase_order(){
        DispatchQueue.main.async {
            ApiService.sharedService.myPurchaseOrder { error, purchaseOrder in
                self.arrOfPrivatePurchaseOrder = []
                if let error = error {
                    print(error.localizedDescription)
                }else if let purchaseOrder = purchaseOrder {
                    for purchaseOrder in purchaseOrder {
                        if self.p_ssn == purchaseOrder.p_id{
                            self.bloodId = purchaseOrder.blood_type
                            self.arrOfPrivatePurchaseOrder.append(purchaseOrder)
                        }
                    }
                    print("purchaseOrder is : \(self.arrOfPrivatePurchaseOrder)")
                    self.HistorytableView.reloadData()
                }
            }
        }
    }
    //get bloodType
    private func getBlood(){
        DispatchQueue.main.async {
            ApiService.sharedService.getBloodType { error, blood in
                if let error = error {
                    print(error.localizedDescription)
                }else if let blood = blood {
                    for blood in blood {
                        if self.bloodId == blood.id{
                            self.bloodTypeName = blood.name
                            print(self.bloodTypeName)
                            
                        }
                    }
                }
            }
        }
    }
    private func getAllBloodNames(){
        ApiService.sharedService.getBloodType { error, blood in
            if let error = error {
                print(error.localizedDescription)
            }else if let blood = blood {
                for blood in blood {
                    self.dicOfBloodTypes[blood.id] = blood.name
                }
                print("dicOfBloodTypes is \(self.dicOfBloodTypes)")
            }
        }
    }
    //segment delegation & functions
    private func segmentControlSelection(indexPath: IndexPath)-> UITableViewCell{
        switch segmentSender {
        case 0:
            let cell = HistorytableView.dequeueReusableCell(withIdentifier: "privateRequestCell")as! privateRequestCell
            let time = arrOfPrivateQuickRequest[indexPath.row].time
            let subTime = time.prefix(16)
            cell.configure(name: "\(arrOfPrivateQuickRequest[indexPath.row].first_name) \(arrOfPrivateQuickRequest[indexPath.row].last_name)", bloodType: arrOfPrivateQuickRequest[indexPath.row].blood_type, address: "(\(arrOfPrivateQuickRequest[indexPath.row].hospital_name))- \(arrOfPrivateQuickRequest[indexPath.row].city_of_hospital)- \(arrOfPrivateQuickRequest[indexPath.row].governorate_name)", time: String(subTime), description: arrOfPrivateQuickRequest[indexPath.row].message, donorImage: arrOfPrivateQuickRequest[indexPath.row].patient_image, numberOfBags: arrOfPrivateQuickRequest[indexPath.row].blood_bags_number)
            cell.privateRequestId = arrOfPrivateQuickRequest[indexPath.row].id
            return cell
        case 1:
            let cell = HistorytableView.dequeueReusableCell(withIdentifier: "HistoryVaccineCell")as! HistoryVaccineCell
            cell.configure(vaccineName: vaccineName, vaccineAmount: "\(arrOfPrivateVaccine[indexPath.row].amount) كيس دم", timeOrderVaccine: arrOfPrivateVaccine[indexPath.row].time, placeOfOrder: self.dicOfPlaceNamesOfVaccine[self.arrOfPrivateVaccine[indexPath.row].delivered_place]  ?? self.arrOfNamesOfPlaces[indexPath.row])
            
            return cell
        case 2:
            let cell = HistorytableView.dequeueReusableCell(withIdentifier: "AcceptOrderBloodCell")as! AcceptOrderBloodCell
            print(self.arrOfPrivatePurchaseOrder)
            let time = arrOfPrivatePurchaseOrder[indexPath.row].time
            let subTime = time.prefix(16)
            cell.configure(bloodType: "فصيله الدم \(self.dicOfBloodTypes[self.arrOfPrivatePurchaseOrder[indexPath.row].blood_type]!)", time: String(subTime), placeName: self.dicOfPlaceNames[self.arrOfPrivatePurchaseOrder[indexPath.row].delivered_place]!)
            return cell
        case 3:
            let cell = HistorytableView.dequeueReusableCell(withIdentifier: "LastDonateHistoryCell")as! LastDonateHistoryCell
            let time = self.arrOfTimesOfDonation.last
            let subTime = time!.prefix(16)
            cell.configure(timeOfLastDonation: String(subTime))
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    private func goTODiffDetailsCell(indexPath: IndexPath){
        if segmentSender == 0{
            let controller = HistoryRequestDetailsViewController.instantiate()
            controller.arrOfPrivateHistoryRequestDetail = arrOfPrivateQuickRequest[indexPath.row]
            controller.requestId = arrOfPrivateQuickRequest[indexPath.row].id
            
            self.present(controller, animated: true, completion: nil)
        }
    }
    //MARK: - actions
    @IBAction func segmentControllTapped(_ sender: UISegmentedControl) {
        setUpSegment()
    }
}
//MARK: - Extensions
extension HistoryMainViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentSender{
        case 0:
            return self.arrOfPrivateQuickRequest.count
        case 1:
            return self.arrOfPrivateVaccine.count
        case 2:
            return self.arrOfPrivatePurchaseOrder.count
        case 3:
            return 1
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        segmentControlSelection(indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segmentSender == 0{
            self.goTODiffDetailsCell(indexPath: indexPath)
        }else{
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
    //for animations
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animate(withDuration: 0.35) {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
    }
    
}
//MARK: - Comments
//NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification), name: Notification.Name (Notifications.detailNot), object: nil)

//@objc func didGetNotification(_ notification: Notification){
//    let patient = notification.object as? Patient
//    label.text = patient?.time
//    view.backgroundColor = .darkGray
//}

//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
