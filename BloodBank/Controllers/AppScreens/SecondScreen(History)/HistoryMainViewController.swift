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
    //quick request
    var arrOfQuickRequest: [QuickRequestData] = [QuickRequestData]()
    var arrOfPrivateQuickRequest: [QuickRequestData] = [QuickRequestData]()
    //vaccine
    var arrOfVaccine: [OrderVaccineData] = [OrderVaccineData]()
    var arrOfPrivateVaccine: [OrderVaccineData] = [OrderVaccineData]()
    
    let def = UserDefaults.standard
    var patient = [Patient(name: "خالد", bloodType: "AB", address: "معمل النور / المنشاه الكبري / السنطه/ الغربيه", time: "خالد", description: "اخي بحاجه الي خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل النور / المنشاه الكبري / السنطه / الغربيهي خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل النور / المنشاه الكبري / السنطه / الغربيه  خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل ا خمسه اكياس دم ف حادثه سياره وحالته خطي خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل النور / المنشاه الكبري / السنطه / الغربيه  خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل ا خمسه اكياس دم ف حادثه سياره وحالته خط ",donorImage: "https://i.pinimg.com/originals/0c/5f/12/0c5f12f37fb6bc00f4d468b5d69e9932.jpg",volunteer: "2") ,Patient(name: "خالد حسين احمد خليفه", bloodType: "B-", address:"معمل النور / المنشاه الكبري / السنطه/ الغربيه", time: "الخامس من يناير عام ٢٠٢٢", description: "اخي بحاجه الي خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل النور / المنشاه الكبري / السنطه / الغربيه خالد",donorImage: "https://i.pinimg.com/originals/57/05/e8/5705e8133fc15fa61e7c5a9951470601.jpg",volunteer: "0"),Patient(name: "خالد", bloodType: "AB-", address: "خالد", time: "خالد", description: "خالد",donorImage: "https://i.pinimg.com/originals/2c/00/c9/2c00c914fb375017343a072aea3be073.jpg",volunteer: "4"),Patient(name: "عمرو", bloodType: "OH-", address: "معمل النور / المنشاه الكبري / السنطه/ الغربيه خالد", time: "خالد", description: "خالد",donorImage: "https://i.pinimg.com/originals/0c/5f/12/0c5f12f37fb6bc00f4d468b5d69e9932.jpg",volunteer: "5"),Patient(name: "خالد حسين احمد حسين خليفه", bloodType: "B-", address: "خالد معمل النور / المنشاه الكبري / السنطه/ الغربيه ", time: "خالد", description: "خالد",donorImage: "https://i.pinimg.com/originals/57/05/e8/5705e8133fc15fa61e7c5a9951470601.jpg",volunteer: "1"),Patient(name: "خالد", bloodType: "AB-", address: "خالد", time: "خالد", description: " اخي بحاجه الي خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل النور / المنشاه الكبري / السنطه / الغربيه خالد",donorImage: "https://i.pinimg.com/originals/0c/5f/12/0c5f12f37fb6bc00f4d468b5d69e9932.jpg",volunteer: "5"),Patient(name: "خالد", bloodType: "OH-", address: "خالد معمل النور / المنشاه الكبري / السنطه/ الغربيه", time: "خالد", description: "خالد",donorImage: "https://i.pinimg.com/originals/2c/00/c9/2c00c914fb375017343a072aea3be073.jpg",volunteer: "6")]
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibCells()
        if let user = def.object(forKey: "userInfo")as? [String]{
            self.p_ssn = user[0]
            print(self.p_ssn ?? "")
        }
        myQuickRequests()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpDesign()
    }
    //MARK: - private func
    private func setUpDesign(){
        segmentControll.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Almarai-Bold", size: 12)!], for: .normal)
    }
    private func registerNibCells(){
        HistorytableView.register(UINib(nibName: "privateRequestCell", bundle: nil), forCellReuseIdentifier: "privateRequestCell")
        HistorytableView.register(UINib(nibName: "RequestsTableViewCell", bundle: nil), forCellReuseIdentifier: "Requestscell")
        HistorytableView.register(UINib(nibName: "HistoryVaccineCell", bundle: nibBundle), forCellReuseIdentifier: "HistoryVaccineCell")
        HistorytableView.register(UINib(nibName: "BloodOrderCell", bundle: nil), forCellReuseIdentifier: "BloodOrderCell")
        HistorytableView.register(UINib(nibName: "LastDonateHistoryCell", bundle: nil), forCellReuseIdentifier: "LastDonateHistoryCell")
        self.noDataImageView.isHidden = true
    }
    private func setUpSegment(){
        let segmentIndex = self.segmentControll.selectedSegmentIndex
        switch segmentIndex{
        case 0 :
            print(segmentIndex)
            self.segmentSender = segmentIndex
            HistorytableView.reloadData()
        case 1 :
            print(segmentIndex)
            self.segmentSender = segmentIndex
            HistorytableView.reloadData()
        case 2 :
            myVaccine()
            getVaccineInfo()
            getPlaceNameOfOrderVaccine()
            print(segmentIndex)
            self.segmentSender = segmentIndex
            HistorytableView.reloadData()
        case 3 :
            print(segmentIndex)
            self.segmentSender = segmentIndex
            HistorytableView.reloadData()
        case 4 :
            print(segmentIndex)
            self.segmentSender = segmentIndex
            HistorytableView.reloadData()
        default:
            break
        }
    }
    // put data from api
    private func myQuickRequests(){
        ApiService.sharedService.allQuickRequests { error, request in
            if let error = error {
                print(error.localizedDescription)
            }else if let request = request {
                self.arrOfQuickRequest = request
                print(self.arrOfQuickRequest)
                for request in self.arrOfQuickRequest {
                    if  self.p_ssn == request.p_ssn{
                        self.arrOfPrivateQuickRequest.append(request)
                        print("my quick request arr:\(self.arrOfPrivateQuickRequest)")
                    }
                    self.HistorytableView.reloadData()
                }
            }
        }
    }
    private func myVaccine(){
        ApiService.sharedService.allOrderVaccines { error, orderVaccine in
            if let error = error {
                print(error.localizedDescription)
            }else if let orderVaccine = orderVaccine {
                self.arrOfVaccine = orderVaccine
                print(self.arrOfVaccine)
                for orderVaccine in self.arrOfVaccine {
                    if  self.p_ssn == orderVaccine.p_ssn{
                        self.arrOfPrivateVaccine.append(orderVaccine)
                        print("my vaccine arr:\(self.arrOfPrivateVaccine)")
                        self.vaccineId = orderVaccine.vaccine_id
                        self.placeId = orderVaccine.delivered_place
                        print("\(self.vaccineId ),\( self.placeId)")
                    }
                    self.HistorytableView.reloadData()
                }
            }else{
                self.noDataImageView.isHidden = false
                self.showNormalAlert(title: "Sorry", message: "There are no vaccination requests :(")
            }
        }
    }
    private func getVaccineInfo(){
        ApiService.sharedService.getAllVaccines { error, vaccine in
            if let error = error {
                print(error.localizedDescription)
            }else if let vaccine = vaccine {
                for vaccine in vaccine {
                    if self.vaccineId == vaccine.vaccine_id{
                        self.vaccineName = vaccine.trade_name
                        print(vaccine.trade_name)
                    }else{
                        print("error in vaccine name")
                    }
                }
            }
        }
    }
    private func getPlaceNameOfOrderVaccine(){
        ApiService.sharedService.getDonatePlace { error, places in
            if let error = error {
                print(error.localizedDescription)
            }else if let places = places {
                for place in places {
                    if self.placeId == place.id{
                        self.placeName = place.place_name
                        print(self.placeName)
                    }else{
                        print("error in vaccine place name")
                    }
                }
            }
        }
    }
    private func segmentControlSelection(indexPath: IndexPath)-> UITableViewCell{
        switch segmentSender {
        case 0:
            if (indexPath.row == 0 || indexPath.row == 1){
                let cell = HistorytableView.dequeueReusableCell(withIdentifier: "privateRequestCell")as! privateRequestCell
                let time = arrOfPrivateQuickRequest[indexPath.row].time
                let subTime = time.prefix(16)
                cell.configure(name: "\(arrOfPrivateQuickRequest[indexPath.row].first_name) \(arrOfPrivateQuickRequest[indexPath.row].last_name)", bloodType: arrOfPrivateQuickRequest[indexPath.row].blood_type, address: "(\(arrOfPrivateQuickRequest[indexPath.row].hospital_name))- \(arrOfPrivateQuickRequest[indexPath.row].city_of_hospital)- \(arrOfPrivateQuickRequest[indexPath.row].governorate_name)", time: String(subTime), description: arrOfPrivateQuickRequest[indexPath.row].message, donorImage: arrOfPrivateQuickRequest[indexPath.row].patient_image, volunteers: arrOfPrivateQuickRequest[indexPath.row].blood_bags_number, numberOfBags: arrOfPrivateQuickRequest[indexPath.row].blood_bags_number)
                return cell
                
            }else if (indexPath.row == 3 ){
                let cell = HistorytableView.dequeueReusableCell(withIdentifier: "HistoryVaccineCell")as! HistoryVaccineCell
                return cell
            }else if (indexPath.row == 2){
                let cell = HistorytableView.dequeueReusableCell(withIdentifier: "BloodOrderCell")as! BloodOrderCell
                return cell
            }else{
                let cell = HistorytableView.dequeueReusableCell(withIdentifier: "LastDonateHistoryCell")as! LastDonateHistoryCell
                return cell
            }
        case 1:
            let cell = HistorytableView.dequeueReusableCell(withIdentifier: "privateRequestCell")as! privateRequestCell
            let time = arrOfPrivateQuickRequest[indexPath.row].time
            let subTime = time.prefix(16)
            cell.configure(name: "\(arrOfPrivateQuickRequest[indexPath.row].first_name) \(arrOfPrivateQuickRequest[indexPath.row].last_name)", bloodType: arrOfPrivateQuickRequest[indexPath.row].blood_type, address: "(\(arrOfPrivateQuickRequest[indexPath.row].hospital_name))- \(arrOfPrivateQuickRequest[indexPath.row].city_of_hospital)- \(arrOfPrivateQuickRequest[indexPath.row].governorate_name)", time: String(subTime), description: arrOfPrivateQuickRequest[indexPath.row].message, donorImage: arrOfPrivateQuickRequest[indexPath.row].patient_image, volunteers: arrOfPrivateQuickRequest[indexPath.row].blood_bags_number, numberOfBags: arrOfPrivateQuickRequest[indexPath.row].blood_bags_number)
            return cell
        case 2:
            let cell = HistorytableView.dequeueReusableCell(withIdentifier: "HistoryVaccineCell")as! HistoryVaccineCell
            cell.configure(vaccineName: vaccineName, vaccineAmount: "\(arrOfPrivateVaccine[indexPath.row].amount) كيس دم", timeOrderVaccine: arrOfPrivateVaccine[indexPath.row].time, placeOfOrder: self.placeName)
            return cell
        case 3:
            let cell = HistorytableView.dequeueReusableCell(withIdentifier: "BloodOrderCell")as! BloodOrderCell
            return cell
        case 4:
            let cell = HistorytableView.dequeueReusableCell(withIdentifier: "LastDonateHistoryCell")as! LastDonateHistoryCell
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    //    private func goToDetailsCell(indexPath: IndexPath){
    //        if segmentSender == 1 || (segmentSender == 0 && indexPath.row == 0) || (segmentSender == 0 && indexPath.row == 3){
    //            let controller = DetailsCellViewController.instantiate()
    //            controller.myPatient = patient[indexPath.row]
    //            self.present(controller, animated: true, completion: nil)
    //        }else{
    //           return
    //        }
    //    }
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
            return self.arrOfPrivateQuickRequest.count  // ممكن اعمل مثلا البرايفت بلس اللقاحات بلس اخر تبرع وهكذا..     (...+...+...+...+...+...)
        case 1:
            return self.arrOfPrivateQuickRequest.count
        case 2:
            return self.arrOfPrivateVaccine.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        segmentControlSelection(indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //        goToDetailsCell(indexPath: indexPath)
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
