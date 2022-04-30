//
//  RequestViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 06/02/2022.
//

import UIKit

class RequestViewController: UIViewController{
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    let navBar = NavigationBar()
    var segmentSender = 0
   
    var arrOfQuickRequest: [QuickRequestData] = [QuickRequestData]()
    //MARK: - --------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAllQuickRequests()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpDesign()
    }
    //MARK: - Private functions
    private func getAllQuickRequests(){
        DispatchQueue.main.async {
            
            ApiService.sharedService.allQuickRequests { error, request in
                if let error = error {
                    print(error.localizedDescription)
                }else if let request = request {
                    self.arrOfQuickRequest = request
                }
                self.tableView.reloadData()
            }
        }
    }
    private func setUpDesign(){
        self.tabBarController?.tabBar.isHidden = false
        navBar.setNavBar(myView: self, title: "Donation Requests".Localized(), viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor, forgroundTitle: UIColor.forgroundTitle, bacgroundView: UIColor.backgroundView)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Almarai-Bold", size: 15)!], for: .normal)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "RequestsTableViewCell", bundle: nil), forCellReuseIdentifier: "Requestscell")
        tableView.register(UINib(nibName: "privateRequestCell", bundle: nil), forCellReuseIdentifier: "privateRequestCell")
    }
    private func goTODiffDetailsCell(indexPath: IndexPath){
        if segmentSender == 0{
            let controller = DetailsCellViewController.instantiate()
            controller.arrOfQuickRequestDetail = arrOfQuickRequest[indexPath.row]
            self.present(controller, animated: true, completion: nil)
        }else{
//            let controller = DetailsCellViewController.instantiate()
//            controller.arrOfQuickRequestDetail = arrOfQuickRequest[indexPath.row]
//            self.present(controller, animated: true, completion: nil)
        }
    }
    //MARK: - Action
    @IBAction func segmentedControlTapped(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            self.segmentSender = sender.selectedSegmentIndex
            print(segmentSender)
            tableView.reloadData()
        }else if sender.selectedSegmentIndex == 1{
            self.segmentSender = sender.selectedSegmentIndex
            print(segmentSender)
            tableView.reloadData()
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
            return 10
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
            cell.configure(name: "\(arrOfQuickRequest[indexPath.row].first_name) \(arrOfQuickRequest[indexPath.row].last_name)", bloodType: arrOfQuickRequest[indexPath.row].blood_type, address: "(\(arrOfQuickRequest[indexPath.row].hospital_name))- \(arrOfQuickRequest[indexPath.row].city_of_hospital)- \(arrOfQuickRequest[indexPath.row].governorate_name)", time: String(subTime), description: arrOfQuickRequest[indexPath.row].message, donorImage: arrOfQuickRequest[indexPath.row].patient_image, volunteers: arrOfQuickRequest[indexPath.row].blood_bags_number, numberOfBags: arrOfQuickRequest[indexPath.row].blood_bags_number)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "privateRequestCell")as! privateRequestCell
//            let time = arrOfQuickRequest[indexPath.row].time
//            let subTime = time.prefix(16)
//            cell.configure(name: "\(arrOfQuickRequest[indexPath.row].first_name) \(arrOfQuickRequest[indexPath.row].last_name)", bloodType: arrOfQuickRequest[indexPath.row].blood_type, address: "(\(arrOfQuickRequest[indexPath.row].hospital_name))- \(arrOfQuickRequest[indexPath.row].city_of_hospital)- \(arrOfQuickRequest[indexPath.row].governorate_name)", time: String(subTime), description: arrOfQuickRequest[indexPath.row].message, donorImage: arrOfQuickRequest[indexPath.row].patient_image, volunteers: arrOfQuickRequest[indexPath.row].blood_bags_number, numberOfBags: arrOfQuickRequest[indexPath.row].blood_bags_number)
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
