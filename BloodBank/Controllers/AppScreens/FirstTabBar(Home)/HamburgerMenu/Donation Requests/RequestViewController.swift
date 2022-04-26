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
   
    
    var patient = [Patient(name: "خالد", bloodType: "AB", address: "معمل النور / المنشاه الكبري / السنطه/ الغربيه", time: "خالد", description: "اخي بحاجه الي خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل النور / المنشاه الكبري / السنطه / الغربيهي خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل النور / المنشاه الكبري / السنطه / الغربيه  خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل ا خمسه اكياس دم ف حادثه سياره وحالته خطي خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل النور / المنشاه الكبري / السنطه / الغربيه  خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل ا خمسه اكياس دم ف حادثه سياره وحالته خط ",donorImage: "https://i.pinimg.com/originals/0c/5f/12/0c5f12f37fb6bc00f4d468b5d69e9932.jpg",volunteer: "4") ,Patient(name: "خالد حسين احمد خليفه", bloodType: "B-", address:"معمل النور / المنشاه الكبري / السنطه/ الغربيه", time: "الخامس من يناير عام ٢٠٢٢", description: "اخي بحاجه الي خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل النور / المنشاه الكبري / السنطه / الغربيه خالد",donorImage: "https://i.pinimg.com/originals/57/05/e8/5705e8133fc15fa61e7c5a9951470601.jpg",volunteer: "6"),Patient(name: "خالد", bloodType: "AB-", address: "خالد", time: "خالد", description: "خالد",donorImage: "https://i.pinimg.com/originals/2c/00/c9/2c00c914fb375017343a072aea3be073.jpg",volunteer: "0"),Patient(name: "عمرو", bloodType: "OH-", address: "معمل النور / المنشاه الكبري / السنطه/ الغربيه خالد", time: "خالد", description: "خالد",donorImage: "https://i.pinimg.com/originals/0c/5f/12/0c5f12f37fb6bc00f4d468b5d69e9932.jpg",volunteer: "2"),Patient(name: "خالد حسين احمد حسين خليفه", bloodType: "B-", address: "خالد معمل النور / المنشاه الكبري / السنطه/ الغربيه ", time: "خالد", description: "خالد",donorImage: "https://i.pinimg.com/originals/57/05/e8/5705e8133fc15fa61e7c5a9951470601.jpg",volunteer: "3"),Patient(name: "خالد", bloodType: "AB-", address: "خالد", time: "خالد", description: " اخي بحاجه الي خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل النور / المنشاه الكبري / السنطه / الغربيه خالد",donorImage: "https://i.pinimg.com/originals/0c/5f/12/0c5f12f37fb6bc00f4d468b5d69e9932.jpg",volunteer: "7"),Patient(name: "خالد", bloodType: "OH-", address: "خالد معمل النور / المنشاه الكبري / السنطه/ الغربيه", time: "خالد", description: "خالد",donorImage: "https://i.pinimg.com/originals/2c/00/c9/2c00c914fb375017343a072aea3be073.jpg",volunteer: "1")]
    
    let privateArr = [Patient(name: "خالد", bloodType: "AB+", address: "معمل النور / المنشاه الكبري / السنطه/ الغربيه", time: "خالد", description: "اخي بحاجه الي خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل النور / المنشاه الكبري / السنطه / الغربيه  خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل ا خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل ا", donorImage: "https://i.pinimg.com/originals/2c/00/c9/2c00c914fb375017343a072aea3be073.jpg",volunteer: "0"),Patient(name: "خالد", bloodType: "ABBA", address: "معمل النور / المنشاه الكبري / السنطه/ الغربيه", time: "خالد", description: "اخي بحاجه الي خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل النور / المنشاه الكبري / السنطه / الغربيه  خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل ا خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل ا", donorImage: "https://i.pinimg.com/originals/0c/5f/12/0c5f12f37fb6bc00f4d468b5d69e9932.jpg",volunteer: "1")]
  //MARK: - --------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpDesign()
    }
    //MARK: - Private functions
    
    private func setUpDesign(){
        self.tabBarController?.tabBar.isHidden = false
        navBar.setNavBar(myView: self, title: "Donation Requests".Localized(), viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor, forgroundTitle: UIColor.forgroundTitle, bacgroundView: UIColor.backgroundView)
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
            return privateArr.count
        default:
            break
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch segmentSender {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Requestscell")as! RequestsTableViewCell
            cell.configure(name: patient[indexPath.row].name!, bloodType: patient[indexPath.row].bloodType!, address: patient[indexPath.row].address!, time: patient[indexPath.row].time!, description: patient[indexPath.row].description!, donorImage: patient[indexPath.row].donorImage!, volunteers: patient[indexPath.row].volunteer!)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Requestscell")as! RequestsTableViewCell
            cell.configure(name: privateArr[indexPath.row].name!, bloodType: privateArr[indexPath.row].bloodType!, address: privateArr[indexPath.row].address!, time: privateArr[indexPath.row].time!, description: privateArr[indexPath.row].description!, donorImage: privateArr[indexPath.row].donorImage!, volunteers: patient[indexPath.row].volunteer!)
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
