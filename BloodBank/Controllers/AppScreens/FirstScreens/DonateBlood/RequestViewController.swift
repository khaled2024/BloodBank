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
    var patient = [Patient(name: "خالد", bloodType: "AB", address: "معمل النور / المنشاه الكبري / السنطه/ الغربيه", time: "خالد", description: "اخي بحاجه الي خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل النور / المنشاه الكبري / السنطه / الغربيه "),Patient(name: "خالد حسين احمد خليفه", bloodType: "B-", address:"معمل النور / المنشاه الكبري / السنطه/ الغربيه", time: "الخامس من يناير عام ٢٠٢٢", description: "اخي بحاجه الي خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل النور / المنشاه الكبري / السنطه / الغربيه خالد"),Patient(name: "خالد", bloodType: "AB-", address: "خالد", time: "خالد", description: "خالد"),Patient(name: "عمرو", bloodType: "OH-", address: "معمل النور / المنشاه الكبري / السنطه/ الغربيه خالد", time: "خالد", description: "خالد"),Patient(name: "خالد حسين احمد حسين خليفه", bloodType: "B-", address: "خالد معمل النور / المنشاه الكبري / السنطه/ الغربيه ", time: "خالد", description: "خالد"),Patient(name: "خالد", bloodType: "AB-", address: "خالد", time: "خالد", description: " اخي بحاجه الي خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل النور / المنشاه الكبري / السنطه / الغربيه خالد"),Patient(name: "خالد", bloodType: "OH-", address: "خالد معمل النور / المنشاه الكبري / السنطه/ الغربيه", time: "خالد", description: "خالد")]
    
    
    
    let privateArr = [Patient(name: "خالد", bloodType: "ABBA", address: "معمل النور / المنشاه الكبري / السنطه/ الغربيه", time: "خالد", description: "اخي بحاجه الي خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل النور / المنشاه الكبري / السنطه / الغربيه ")]
  //MARK: - --------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDesign()
       
        
    }
    //MARK: - Private functions
    
    
    private func setUpDesign(){
        self.tabBarController?.tabBar.isHidden = false
        navBar.setNavBar(myView: self, title: "طلبات التبرع", viewController: view, navBarColor: #colorLiteral(red: 0.9845134616, green: 0.9810839295, blue: 0.9719126821, alpha: 1), navBarTintColor: #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1), forgroundTitle: #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1), bacgroundView: #colorLiteral(red: 0.9845134616, green: 0.9810839295, blue: 0.9719126821, alpha: 1))
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Almarai-Bold", size: 15)!], for: .normal)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "RequestsTableViewCell", bundle: nil), forCellReuseIdentifier: "Requestscell")
    }
    private func goTODiffDetailsCell(indexPath: IndexPath){
        if segmentSender == 0{
            let controller = DetailsCellViewController.instantiate()
            controller.myPatient = patient[indexPath.row]
            self.present(controller, animated: true, completion: nil)
        }else{
            let controller = DetailsCellViewController.instantiate()
            controller.myPatient = privateArr[indexPath.row]
            self.present(controller, animated: true, completion: nil)

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
            return patient.count
        case 1:
            return 1
        default:
            break
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch segmentSender {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Requestscell")as! RequestsTableViewCell
            cell.configure(name: patient[indexPath.row].name!, bloodType: patient[indexPath.row].bloodType!, address: patient[indexPath.row].address!, time: patient[indexPath.row].time!, description: patient[indexPath.row].description!)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Requestscell")as! RequestsTableViewCell
            cell.configure(name: privateArr[indexPath.row].name!, bloodType: privateArr[indexPath.row].bloodType!, address: privateArr[indexPath.row].address!, time: privateArr[indexPath.row].time!, description: privateArr[indexPath.row].description!)
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.goTODiffDetailsCell(indexPath: indexPath)

    }
    
}
