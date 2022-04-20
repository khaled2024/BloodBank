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
struct Volunteer {
    var image: String?
    var name: String?
    var location: String?
    var bloodType: String?
}

class VolunteersViewController: UIViewController{
    //MARK: - Outlets
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var bloodSearchBar: UISearchBar!
    @IBOutlet weak var voluntersTableView: UITableView!
    //MARK: - Vars
    var volunteer =  [Volunteer]()
    var filteredData = [Volunteer]()
    let navBar = NavigationBar()
    let transparentView = UIView()
    let filteredtableView = UITableView()
    var selectedBtn = UIButton()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setUpRegisterCells()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpDesign()
    }
    //MARK: - Private func
    private func setUpRegisterCells(){
        self.voluntersTableView.register(UINib(nibName: "VolunteersTableViewCell", bundle: nil), forCellReuseIdentifier: "VolunteersTableViewCell")
        self.filteredtableView.register(filteredTableViewCell.self, forCellReuseIdentifier: "filteredTableViewCell")
    }
    private func setUpDesign(){
        self.tabBarController?.tabBar.isHidden = false
        navBar.setNavBar(myView: self, title: "volunteers".Localized(), viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor, forgroundTitle: UIColor.forgroundTitle, bacgroundView: UIColor.backgroundView)
        bloodSearchBar.placeholder = "Search For Donor"
    }
    private func setUp(){
        self.volunteer.append(.init(image: "donorLogo", name: "خالد حسين", location: "المنشاه الكبري / السنطه / طنطا / الغربيه", bloodType: "A+"))
        self.volunteer.append(.init(image: "donorLogo", name: "Amr hussien", location: "tanta / el-santa", bloodType: "B+"))
        self.volunteer.append(.init(image: "f1", name: "Assel hussien", location: "tanta / el-santa", bloodType: "AB+"))
        self.volunteer.append(.init(image: "f2", name: "khaled hussien", location: "tanta / el-santa", bloodType: "OH+"))
        self.volunteer.append(.init(image: "f3", name: "Amr hussien", location: "tanta / el-santa", bloodType: "O-"))
        self.volunteer.append(.init(image: "f4", name: "Amr hussien", location: "tanta / el-santa", bloodType: "O-"))
        self.volunteer.append(.init(image: "f5", name: "Amr hussien", location: "tanta / el-santa", bloodType: "O-"))
        self.volunteer.append(.init(image: "f6", name: "Amr hussien", location: "tanta / el-santa", bloodType: "O-"))
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
            return volunteer.count
        }else if tableView == self.filteredtableView{
            return Arrays.arrayOfBloodType.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.voluntersTableView{
            let cell = voluntersTableView.dequeueReusableCell(withIdentifier: "VolunteersTableViewCell", for: indexPath)as! VolunteersTableViewCell
            cell.config(volunteer[indexPath.row])
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
            let donorVC = DonorViewController.instantiate()
            self.present(donorVC, animated: true)
        }else if tableView == self.filteredtableView{
            self.removetransparentView()
            print(Arrays.arrayOfBloodType[indexPath.row])
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
extension VolunteersViewController:UISearchBarDelegate,UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        //
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchBarText = bloodSearchBar.text , !searchBarText.isEmpty{
            print(searchBarText)
            self.view.endEditing(true)
        }else{
            print("Enter Blood Type!")
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchBar.text!
        filteredData = volunteer.filter({ volnter in
            let searchTextMatch = volnter.name?.lowercased().contains(searchText.lowercased())
            return searchTextMatch!
        })
    }
}
