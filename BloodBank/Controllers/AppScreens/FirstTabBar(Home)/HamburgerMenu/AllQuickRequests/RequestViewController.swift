//
//  RequestViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 06/02/2022.
//

import UIKit

class RequestViewController: UIViewController{
    
    @IBOutlet weak var emptyPageLbl: UILabel!
    @IBOutlet weak var noDataImage: UIImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    let navBar = NavigationBar()
    var segmentSender = 0
    var p_ssn: String!
    var arrOfQuickRequest: [QuickRequestData] = [QuickRequestData]()
    var arrOfPrivateQuickRequest: [QuickRequestData] = [QuickRequestData]()
    let refreshControll = UIRefreshControl()
    var privateRequestId = ""
    var volunteersNum = 0
    var arrOfSavedRequests : [SavedBloodRequestData] = [SavedBloodRequestData]()
    var myRequestId  = ""
    var IdOfRequestForDeletion = "error in request id"
    //MARK: - --------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataOfUser()
        self.getAllQuickRequests()
        self.privateQuickRequests()
        refreshControll.tintColor = .systemRed
        refreshControll.addTarget(self, action: #selector(refreshTapped), for: .valueChanged)
        self.tableView.addSubview(refreshControll)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpDesign()
        self.tableView.reloadData()
        
    }
    @objc func refreshTapped(){
        if segmentSender == 0{
            tableView.beginUpdates()
            self.getAllQuickRequests()
            self.privateQuickRequests()
            tableView.endUpdates()
            refreshControll.endRefreshing()
        }else{
            refreshControll.endRefreshing()
        }
        
    }
    //MARK: - Private functions
    private func setUpDesign(){
        self.tabBarController?.tabBar.isHidden = false
        navBar.setNavBar(myView: self, title: "Donation Requests".Localized(), viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor, forgroundTitle: UIColor.forgroundTitle, bacgroundView: UIColor.backgroundView)
        
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Almarai-Bold", size: 15)!], for: .normal)
        segmentedControl.setTitle("General".Localized(), forSegmentAt: 0)
        segmentedControl.setTitle("Private".Localized(), forSegmentAt: 1)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "RequestsTableViewCell", bundle: nil), forCellReuseIdentifier: "Requestscell")
        tableView.register(UINib(nibName: "privateRequestCell", bundle: nil), forCellReuseIdentifier: "privateRequestCell")
        self.emptyPageLbl.isHidden = true
        self.noDataImage.isHidden = true
    }
    private func getAllQuickRequests(){
        DispatchQueue.main.async {
            self.arrOfPrivateQuickRequest = []
            ApiService.sharedService.allQuickRequests { error, request in
                if let error = error {
                    self.showNormalAlert(title: "للاسف", message: "لا يمكن الاتصال بالخادم")
                    self.tableView.isHidden = true
                    self.noDataImage.image = UIImage(named: "someThinfWrong2")
                    self.emptyPageLbl.isHidden = true
                    self.noDataImage.isHidden = false
                    print(error.localizedDescription)
                }else if let request = request {
                    self.tableView.isHidden = false
                    self.noDataImage.isHidden = true
                    self.emptyPageLbl.isHidden = true
                    self.arrOfQuickRequest = request
                }
                self.tableView.reloadData()
            }
        }
    }
    private func privateQuickRequests(){
        ApiService.sharedService.allQuickRequests { error, request in
            if let error = error {
                print(error.localizedDescription)
            }else if let request = request {
                self.arrOfQuickRequest = request
                print(self.arrOfQuickRequest)
                for request in self.arrOfQuickRequest {
                    if  self.p_ssn == request.p_ssn{
                        self.arrOfPrivateQuickRequest.append(request)
                        print("private arr :\(self.arrOfPrivateQuickRequest)")
                    }
                    self.tableView.reloadData()
                    if self.arrOfPrivateQuickRequest.count == 0{
                        self.tableView.isHidden = true
                        self.noDataImage.isHidden = false
                        self.noDataImage.image = UIImage(named: "emptyPage-2")
                        self.emptyPageLbl.isHidden = false
                    }
                }
            }
        }
    }
    
    private func setDataOfUser(){
        let def = UserDefaults.standard
        if let userInfo = def.object(forKey: "userInfo")as? [String]{
            self.p_ssn = userInfo[0]
            print(self.p_ssn!)
            
        }
    }
    private func goTODiffDetailsCell(indexPath: IndexPath){
        if segmentSender == 0{
            let controller = DetailsCellViewController.instantiate()
            controller.arrOfQuickRequestDetail = arrOfQuickRequest[indexPath.row]
            //            self.myRequestId = arrOfQuickRequest[indexPath.row].id
            controller.requestId = arrOfQuickRequest[indexPath.row].id
            //            print(arrOfQuickRequest[indexPath.row].id)
            //            self.allGoingDonor(idOfRequest: self.myRequestId)
            
            self.present(controller, animated: true, completion: nil)
        }else{
            let controller = DetailPrivateCellViewController.instantiate()
            controller.arrOfPrivateQuickRequestDetail = arrOfPrivateQuickRequest[indexPath.row]
            controller.requestId = arrOfPrivateQuickRequest[indexPath.row].id
            self.present(controller, animated: true, completion: nil)
        }
        
    }
    
    //MARK: - Action
    @IBAction func segmentedControlTapped(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            if self.arrOfQuickRequest.count == 0{
                self.tableView.isHidden = true
                self.noDataImage.isHidden = false
                self.noDataImage.image = UIImage(named: "emptyPage-2")
                self.emptyPageLbl.isHidden = false
            }else{
                self.segmentSender = sender.selectedSegmentIndex
                print(segmentSender)
                self.tableView.isHidden = false
                self.noDataImage.isHidden = true
                self.emptyPageLbl.isHidden = true
                tableView.reloadData()
            }
        }else if sender.selectedSegmentIndex == 1{
            if self.arrOfPrivateQuickRequest.count == 0{
                self.tableView.isHidden = true
                self.noDataImage.isHidden = false
                self.noDataImage.image = UIImage(named: "emptyPage-2")
                self.emptyPageLbl.isHidden = false
            }else{
                self.segmentSender = sender.selectedSegmentIndex
                print(segmentSender)
                self.noDataImage.isHidden = true
                self.emptyPageLbl.isHidden = true
                tableView.reloadData()
            }
        }
    }
}
//MARK: - extinsion
extension RequestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentSender {
        case 0:
            return arrOfQuickRequest.count
        case 1:
            return arrOfPrivateQuickRequest.count
        default:
            break
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch segmentSender {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Requestscell")as! RequestsTableViewCell
            let time = arrOfQuickRequest[indexPath.row].time
            let subTime = time.prefix(16)
            cell.configure(name: "\(arrOfQuickRequest[indexPath.row].first_name) \(arrOfQuickRequest[indexPath.row].last_name)", bloodType: arrOfQuickRequest[indexPath.row].blood_type, address: "(\(arrOfQuickRequest[indexPath.row].hospital_name))- \(arrOfQuickRequest[indexPath.row].city_of_hospital)- \(arrOfQuickRequest[indexPath.row].governorate_name)", time: String(subTime), description: arrOfQuickRequest[indexPath.row].message, donorImage: arrOfQuickRequest[indexPath.row].patient_image, numberOfBags: arrOfQuickRequest[indexPath.row].blood_bags_number)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "privateRequestCell")as! privateRequestCell
            let time = arrOfPrivateQuickRequest[indexPath.row].time
            let subTime = time.prefix(16)
            cell.configure(name: "\(arrOfPrivateQuickRequest[indexPath.row].first_name) \(arrOfPrivateQuickRequest[indexPath.row].last_name)", bloodType: arrOfPrivateQuickRequest[indexPath.row].blood_type, address: "(\(arrOfPrivateQuickRequest[indexPath.row].hospital_name))- \(arrOfPrivateQuickRequest[indexPath.row].city_of_hospital)- \(arrOfPrivateQuickRequest[indexPath.row].governorate_name)", time: String(subTime), description: arrOfPrivateQuickRequest[indexPath.row].message, donorImage: arrOfPrivateQuickRequest[indexPath.row].patient_image, numberOfBags: arrOfPrivateQuickRequest[indexPath.row].blood_bags_number)
            //            cell.privateRequestId = arrOfPrivateQuickRequest[indexPath.row].id
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.goTODiffDetailsCell(indexPath: indexPath)
    }
    //for animations
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animate(withDuration: 0.35) {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
    }
}
