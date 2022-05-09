//
//  FavoriteViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 23/04/2022.
//

import UIKit

class FavoriteViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var noDataImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var favoriteTableView: UITableView!
    //MARK: - Vars
    let navBar = NavigationBar()
    let def = UserDefaults.standard
    var arrOfFavoriteRequest: [QuickRequestData] = [QuickRequestData]()
    var p_ssn = ""
    var id = ""
    var arrOfRequestsId: [String] = []
    var arrOfIds: [String] = []
    var refreshControll = UIRefreshControl()
    var arrOfMyFav: [SavedBloodRequestData] = [SavedBloodRequestData]()
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.favoriteTableView.register(UINib(nibName: "favoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "favoriteTableViewCell")
        if let userInfo = def.object(forKey: "userInfo")as? [String]{
            self.p_ssn = userInfo[0]
        }
        print(self.p_ssn)
        allSavedRequests()
        getDetailsOfSavedRequest()
        refreshControll.tintColor = .systemPink
        favoriteTableView.addSubview(refreshControll)
        refreshControll.addTarget(self, action: #selector(refreshTapped), for: .valueChanged)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpDesign()
    }
    //MARK: - private functions
    @objc func refreshTapped(){
        favoriteTableView.beginUpdates()
        allSavedRequests()
        getDetailsOfSavedRequest()
        favoriteTableView.reloadData()
        favoriteTableView.endUpdates()
        refreshControll.endRefreshing()
    }
    private func allSavedRequests(){
        ApiService.sharedService.allSavedBloodRequests { error, savedRequest in
            self.arrOfRequestsId = []
            if let error = error {
                print(error.localizedDescription)
                self.showNormalAlert(title: "للاسف", message: "لا يمكن الاتصال بالخادم")
                self.favoriteTableView.isHidden = true
                self.noDataImage.isHidden = false
            }else if let savedRequest = savedRequest {
                self.favoriteTableView.isHidden = false
                self.noDataImage.isHidden = true
                for savedRequest in savedRequest {
                    if self.p_ssn == savedRequest.p_ssn{
                        self.arrOfMyFav.append(savedRequest)
                        self.arrOfRequestsId.append(savedRequest.request_id)
                        self.arrOfIds.append(savedRequest.id)
                        //                        self.arrOfIds.insert(savedRequest.id, at: 0)
                    }
                }
                if self.arrOfIds.count == 0{
                    self.showNormalAlert(title: "Sorry", message: "لا يوجد طلبات دم عاجله محفوظه :(")
                }
                print(self.arrOfRequestsId)
                print(self.arrOfIds)
            }
            self.favoriteTableView.reloadData()
        }
    }
    func getDetailsOfSavedRequest(){
        ApiService.sharedService.allQuickRequests { error, request in
            self.arrOfFavoriteRequest = []
            if let error = error {
                print(error.localizedDescription)
            }else if let request = request {
                for request in request {
                    for id in self.arrOfRequestsId {
                        if request.id == id{
                            self.arrOfFavoriteRequest.append(request)
                        }
                    }
                }
                if self.arrOfFavoriteRequest.count == 0{
                    self.noDataImage.isHidden = false
                    self.favoriteTableView.isHidden = true
                }else{
                    self.favoriteTableView.isHidden = false
                    self.noDataImage.isHidden = true
                }
                print(self.arrOfFavoriteRequest)
            }
            self.favoriteTableView.reloadData()
            
        }
    }
    private func setUpDesign(){
        navBar.setNavBar(myView: self, title: "Favorite".Localized(), viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor, forgroundTitle: UIColor.forgroundTitle, bacgroundView: UIColor.backgroundView)
    }
    private func diffDetails(indexPath: IndexPath){
        let controll = FavoriteDetailsViewController.instantiate()
        controll.arrOfFavoriteRequestDetail = self.arrOfFavoriteRequest[indexPath.row]
        controll.requestId = arrOfIds[indexPath.row]
        controll.p_ssn = self.p_ssn
        controll.tableView = favoriteTableView
        print("id of request : \(arrOfIds[indexPath.row])")
                self.present(controll, animated: true, completion: nil)
        
    }
    //MARK: - Actions
}
//MARK: - UITableViewDelegate, UITableViewDataSource
extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrOfFavoriteRequest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: "favoriteTableViewCell", for: indexPath)as! favoriteTableViewCell
        let time = arrOfFavoriteRequest[indexPath.row].time
        let subTime = time.prefix(16)
        cell.configure(bloodBags: self.arrOfFavoriteRequest[indexPath.row].blood_bags_number, volunteer:self.arrOfFavoriteRequest[indexPath.row].blood_bags_number , message: self.arrOfFavoriteRequest[indexPath.row].message, time: String(subTime), address: "(\(arrOfFavoriteRequest[indexPath.row].hospital_name))- \(arrOfFavoriteRequest[indexPath.row].city_of_hospital)- \(arrOfFavoriteRequest[indexPath.row].governorate_name)", name: "\(arrOfFavoriteRequest[indexPath.row].first_name) \(arrOfFavoriteRequest[indexPath.row].last_name)", bloodType: arrOfFavoriteRequest[indexPath.row].blood_type, bloodImage: "f2")
        cell.requestId = arrOfIds[indexPath.row]
        cell.p_ssn = self.p_ssn
        cell.tableView = favoriteTableView
        print("id of request : \(arrOfIds[indexPath.row])")
        
        return cell
    }
    //for animations
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animate(withDuration: 0.35) {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.diffDetails(indexPath: indexPath)
    }
    private func removeRequest(){
        ApiService.sharedService.deleteFavoriteRequest(id: self.id)
        
    }
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        self.id = arrOfMyFav[indexPath.row].id
//        let deleteAction = UIContextualAction(style: .normal, title: "") { action, view, completionHandeler in
//            self.removeRequest()
//            self.arrOfMyFav.remove(at: indexPath.row)
//            tableView.beginUpdates()
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//            tableView.endUpdates()
//            completionHandeler(true)
//        }
//        deleteAction.image = UIImage(systemName: "trash")
//        deleteAction.backgroundColor = .systemRed
//
//        return UISwipeActionsConfiguration(actions: [deleteAction])
//    }
    
}