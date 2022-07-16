//
//  VolunteersViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 19/04/2022.
//

import UIKit
// for filteded tableview
class filteredTableViewCell: UITableViewCell{
}

class VolunteersViewController: UIViewController{
    //MARK: - Outlets
    @IBOutlet weak var noDataImageView: UIImageView!
    @IBOutlet weak var filterSegmentControll: UISegmentedControl!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var bloodSearchBar: UISearchBar!
    @IBOutlet weak var voluntersTableView: UITableView!
    //MARK: - Vars
    let navBar = NavigationBar()
    let transparentView = UIView()
    let filteredtableView = UITableView()
    var selectedBtn = UIButton()
    var selectedFilter: String!
    var initialVolunteerAry: [userData] = [userData]()
    var arrOfVolunteers: [userData] = [userData]()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setUpRegisterCells()
        getAllVolunteers()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpDesign()
    }
    //MARK: - Private func
    //    someThinfWrong2
    //    errorSearch
    private func getAllVolunteers(){
        ApiService.sharedService.checkSignIn { error, user in
            if let error = error {
                print(error.localizedDescription)
                self.showNormalAlert(title: "للاسف", message: "لا يمكن الاتصال بالخادم")
                self.noDataImageView.image = UIImage(named: "someThinfWrong2")
                self.voluntersTableView.isHidden = true
                self.noDataImageView.isHidden = false
            }else if let user = user {
                self.voluntersTableView.isHidden = false
                self.arrOfVolunteers = user
                self.initialVolunteerAry = user
            }
            self.voluntersTableView.reloadData()
        }
    }
    private func setUpRegisterCells(){
        self.voluntersTableView.register(UINib(nibName: "VolunteersTableViewCell", bundle: nil), forCellReuseIdentifier: "VolunteersTableViewCell")
        self.filteredtableView.register(filteredTableViewCell.self, forCellReuseIdentifier: "filteredTableViewCell")
    }
    private func setUpDesign(){
        self.tabBarController?.tabBar.isHidden = false
        navBar.setNavBar(myView: self, title: "volunteers".Localized(), viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor, forgroundTitle: UIColor.forgroundTitle, bacgroundView: UIColor.backgroundView)
        bloodSearchBar.placeholder = "Search For Donor"
        bloodSearchBar.layer.cornerRadius = 10
        bloodSearchBar.backgroundColor = .clear
        filterSegmentControll.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Almarai-Bold", size: 15)! ], for: .normal)
        filterSegmentControll.setTitle("Blood Type".Localized(), forSegmentAt: 0)
        filterSegmentControll.setTitle("Name".Localized(), forSegmentAt: 1)
        filterSegmentControll.setTitle("Location".Localized(), forSegmentAt: 2)
        noDataImageView.isHidden = true
    }
    private func setUp(){
        bloodSearchBar.delegate = self
        voluntersTableView.delegate = self
        voluntersTableView.dataSource = self
        filteredtableView.delegate = self
        filteredtableView.dataSource = self
    }
    
    private func frameOfTableViewX()-> CGFloat{
        let currentLang = Locale.current.languageCode
        if currentLang == "en"{
            return selectedBtn.frame.origin.x - 100
        }else{
            return selectedBtn.frame.origin.x
        }
    }
    private func addTransparentView(frames: CGRect) {
        transparentView.frame =  self.mainView.frame
        self.view.addSubview (transparentView)
        filteredtableView.frame = CGRect(x: self.frameOfTableViewX(), y: frames.origin.y + frames.height + 5, width: frames.width + 100, height: 0)
        self.view.addSubview(filteredtableView)
        filteredtableView.layer.cornerRadius = 5
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        let tapgesture = UITapGestureRecognizer (target: self, action:#selector (removetransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate (withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0,
                        initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.4
            self.filteredtableView.frame = CGRect(x: self.frameOfTableViewX(), y: frames.origin.y + frames.height + 5, width: frames.width + 100, height: 200)
            self.navigationController?.navigationBar.backgroundColor = UIColor.gray.withAlphaComponent(0)
        }, completion: nil)
    }
    @objc func removetransparentView(){
        let frames = selectedBtn.frame
        UIView.animate (withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0,
                        initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.filteredtableView.frame = CGRect(x: self.frameOfTableViewX(), y: frames.origin.y + frames.height, width: frames.width + 100, height: 0)
            self.navigationController?.navigationBar.backgroundColor = UIColor.clear.withAlphaComponent(0)
        }, completion: nil)
    }
    
    //MARK: - Actions
    @IBAction func filterBtnTapped(_ sender: UIButton) {
        self.selectedBtn = filterBtn
        addTransparentView(frames: filterBtn.frame)
    }
}
//MARK: - extension UITableViewDataSource , UITableViewDelegate:
extension VolunteersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.voluntersTableView{
            return arrOfVolunteers.count
        }else if tableView == self.filteredtableView{
            return Arrays.arrayOfBloodType.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.voluntersTableView{
            let cell = voluntersTableView.dequeueReusableCell(withIdentifier: "VolunteersTableViewCell", for: indexPath)as! VolunteersTableViewCell
            cell.config(arrOfVolunteers[indexPath.row])
            return cell
        }else if tableView == self.filteredtableView{
            let cell = filteredtableView.dequeueReusableCell(withIdentifier: "filteredTableViewCell", for: indexPath) as! filteredTableViewCell
            cell.textLabel?.text = Arrays.arrayOfBloodType[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        filteredtableView.deselectRow(at: indexPath, animated: true)
        if tableView == self.voluntersTableView{
            //            let donorVC = DonorViewController.instantiate()
            //            self.present(donorVC, animated: true)
        }else if tableView == self.filteredtableView{
            let bloodTypeFilter = Arrays.arrayOfBloodType[indexPath.row]
            self.removetransparentView()
            print(bloodTypeFilter)
            self.selectedFilter = bloodTypeFilter
            self.bloodSearchBar.text = bloodTypeFilter
            self.tvBloodFilteration(text: bloodTypeFilter)
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
//MARK: - extension UISearchBarDelegate:
extension VolunteersViewController:UISearchBarDelegate{
    
    private func tvBloodFilteration(text: String){
        let segment = filterSegmentControll.selectedSegmentIndex
        if  (segment == 0 || segment == 1 || segment == 2) {
            arrOfVolunteers = initialVolunteerAry.filter { (data)-> Bool in
                return (data.blood_type.lowercased().contains(text.lowercased()))
            }
            voluntersTableView.reloadData()
            if arrOfVolunteers.count == 0{
                self.voluntersTableView.isHidden = true
                self.noDataImageView.image = UIImage(named: "errorSearch")
                self.noDataImageView.isHidden = false
                //                self.showNormalAlert(title: "", message: "لا يوجد متبرعين في الوقت الحالي ")
            }
        }
    }
    // filter the tableView
    private func filterTableView(text: String){
        switch filterSegmentControll.selectedSegmentIndex{
        case 0:
            arrOfVolunteers = initialVolunteerAry.filter { (data)-> Bool in
                return (data.blood_type.lowercased().contains(text.lowercased()))
            }
            voluntersTableView.reloadData()
            if arrOfVolunteers.count == 0{
                self.voluntersTableView.isHidden = true
                self.noDataImageView.image = UIImage(named: "errorSearch")
                self.noDataImageView.isHidden = false
            }
            break
        case 1:
            arrOfVolunteers = initialVolunteerAry.filter { (data)-> Bool in
                return (data.p_first_name.lowercased().contains(text.lowercased()))
            }
            voluntersTableView.reloadData()
            if arrOfVolunteers.count == 0{
                self.voluntersTableView.isHidden = true
                self.noDataImageView.image = UIImage(named: "errorSearch")
                self.noDataImageView.isHidden = false
            }
            break
        case 2:
            arrOfVolunteers = initialVolunteerAry.filter { (data)-> Bool in
                return (data.governorate_name.lowercased().contains(text.lowercased()))
            }
            voluntersTableView.reloadData()
            if arrOfVolunteers.count == 0{
                self.voluntersTableView.isHidden = true
                self.noDataImageView.image = UIImage(named: "errorSearch")
                self.noDataImageView.isHidden = false
            }
            break
        default:
            arrOfVolunteers = initialVolunteerAry
            self.voluntersTableView.reloadData()
            if arrOfVolunteers.count == 0{
                self.voluntersTableView.isHidden = true
                self.noDataImageView.image = UIImage(named: "errorSearch")
                self.noDataImageView.isHidden = false
            }
            break
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        voluntersTableView.isHidden = false
        if searchText.isEmpty{
            self.noDataImageView.isHidden = true
            arrOfVolunteers = initialVolunteerAry
            self.voluntersTableView.reloadData()
        }else{
            filterTableView(text: searchText)
        }
    }
}
