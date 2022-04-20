//
//  AppointmentMainViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 23/02/2022.
//

import UIKit

class HistoryMainViewController: UIViewController {
    //MARK: - outlets
    @IBOutlet weak var segmentControll: UISegmentedControl!
    @IBOutlet weak var HistorytableView: UITableView!
    //MARK: - Variabels
    let navBar = NavigationBar()
    var segmentSender = 0
    var patient = [Patient(name: "خالد", bloodType: "AB", address: "معمل النور / المنشاه الكبري / السنطه/ الغربيه", time: "خالد", description: "اخي بحاجه الي خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل النور / المنشاه الكبري / السنطه / الغربيهي خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل النور / المنشاه الكبري / السنطه / الغربيه  خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل ا خمسه اكياس دم ف حادثه سياره وحالته خطي خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل النور / المنشاه الكبري / السنطه / الغربيه  خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل ا خمسه اكياس دم ف حادثه سياره وحالته خط ",donorImage: "https://i.pinimg.com/originals/0c/5f/12/0c5f12f37fb6bc00f4d468b5d69e9932.jpg") ,Patient(name: "خالد حسين احمد خليفه", bloodType: "B-", address:"معمل النور / المنشاه الكبري / السنطه/ الغربيه", time: "الخامس من يناير عام ٢٠٢٢", description: "اخي بحاجه الي خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل النور / المنشاه الكبري / السنطه / الغربيه خالد",donorImage: "https://i.pinimg.com/originals/57/05/e8/5705e8133fc15fa61e7c5a9951470601.jpg"),Patient(name: "خالد", bloodType: "AB-", address: "خالد", time: "خالد", description: "خالد",donorImage: "https://i.pinimg.com/originals/2c/00/c9/2c00c914fb375017343a072aea3be073.jpg"),Patient(name: "عمرو", bloodType: "OH-", address: "معمل النور / المنشاه الكبري / السنطه/ الغربيه خالد", time: "خالد", description: "خالد",donorImage: "https://i.pinimg.com/originals/0c/5f/12/0c5f12f37fb6bc00f4d468b5d69e9932.jpg"),Patient(name: "خالد حسين احمد حسين خليفه", bloodType: "B-", address: "خالد معمل النور / المنشاه الكبري / السنطه/ الغربيه ", time: "خالد", description: "خالد",donorImage: "https://i.pinimg.com/originals/57/05/e8/5705e8133fc15fa61e7c5a9951470601.jpg"),Patient(name: "خالد", bloodType: "AB-", address: "خالد", time: "خالد", description: " اخي بحاجه الي خمسه اكياس دم ف حادثه سياره وحالته خطيره جدا ارجو المساعده ف اسرع وقت ف معمل النور / المنشاه الكبري / السنطه / الغربيه خالد",donorImage: "https://i.pinimg.com/originals/0c/5f/12/0c5f12f37fb6bc00f4d468b5d69e9932.jpg"),Patient(name: "خالد", bloodType: "OH-", address: "خالد معمل النور / المنشاه الكبري / السنطه/ الغربيه", time: "خالد", description: "خالد",donorImage: "https://i.pinimg.com/originals/2c/00/c9/2c00c914fb375017343a072aea3be073.jpg")]
   
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibCells()
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
        HistorytableView.register(UINib(nibName: "RequestsTableViewCell", bundle: nil), forCellReuseIdentifier: "Requestscell")
        HistorytableView.register(UINib(nibName: "HistoryVaccineCell", bundle: nibBundle), forCellReuseIdentifier: "HistoryVaccineCell")
        HistorytableView.register(UINib(nibName: "BloodOrderCell", bundle: nil), forCellReuseIdentifier: "BloodOrderCell")
        HistorytableView.register(UINib(nibName: "LastDonateHistoryCell", bundle: nil), forCellReuseIdentifier: "LastDonateHistoryCell")
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
    private func segmentControlSelection(indexPath: IndexPath)-> UITableViewCell{
        switch segmentSender {
        case 0:
            if (indexPath.row == 0 || indexPath.row == 3){
                let cell = HistorytableView.dequeueReusableCell(withIdentifier: "Requestscell")as! RequestsTableViewCell
                cell.configure(name: patient[indexPath.row].name!, bloodType: patient[indexPath.row].bloodType!, address: patient[indexPath.row].address!, time: patient[indexPath.row].time!, description: patient[indexPath.row].description!, donorImage: patient[indexPath.row].donorImage!)
                return cell
            }else if (indexPath.row == 1 ){
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
            let cell = HistorytableView.dequeueReusableCell(withIdentifier: "Requestscell")as! RequestsTableViewCell
            cell.configure(name: patient[indexPath.row].name!, bloodType: patient[indexPath.row].bloodType!, address: patient[indexPath.row].address!, time: patient[indexPath.row].time!, description: patient[indexPath.row].description!, donorImage: patient[indexPath.row].donorImage!)
            return cell
        case 2:
            let cell = HistorytableView.dequeueReusableCell(withIdentifier: "HistoryVaccineCell")as! HistoryVaccineCell
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
    private func goToDetailsCell(indexPath: IndexPath){
        if segmentSender == 1 || (segmentSender == 0 && indexPath.row == 0) || (segmentSender == 0 && indexPath.row == 3){
            let controller = DetailsCellViewController.instantiate()
            controller.myPatient = patient[indexPath.row]
            self.present(controller, animated: true, completion: nil)
        }else{
           return
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
        return patient.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       segmentControlSelection(indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        goToDetailsCell(indexPath: indexPath)
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
