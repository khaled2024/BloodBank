//
//  VaccineCollectionViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 14/04/2022.
//

import UIKit
struct VaccineItem {
    var imageVaccine: UIImage
    var titleVaccine: String
    var subTitleVaccine: String
    
    var scienceVaccineName: String
    var tradeVaccineName: String
    var vaccineorigin: String
    var vaccineCountry: String
    var packagePrice: Int
    var packageNumber: Int
    var totalPrice: Int
}
class VaccineCollectionViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var noDataImage: UIImageView!
    @IBOutlet weak var vaccineCollectionView: UICollectionView!
    let navBar = NavigationBar()
    var vaccineItem = [VaccineItem]()
    let cellScale: CGFloat = 0.6
    var arrOfVaccines: [VaccineData] = [VaccineData]()
    let randomNum = Int.random(in: 1...6)
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        vaccineCollectionView.delegate = self
        vaccineCollectionView.dataSource = self
        self.getAllVaccine()
       
        setCellSize()
    }
    //MARK: - Private func
    private func getAllVaccine(){
        ApiService.sharedService.getAllVaccines { error, vaccine in
            if let error = error {
                print(error.localizedDescription)
                self.showNormalAlert(title: "للاسف", message: "لا يمكن الاتصال بالخادم")
                self.vaccineCollectionView.isHidden = true
                self.noDataImage.isHidden = false
            }else{
                self.vaccineCollectionView.isHidden = false
                self.noDataImage.isHidden = true
            }
            if let vaccine = vaccine {
                self.arrOfVaccines = vaccine
            }
            if self.arrOfVaccines.count == 0{
                self.showNormalAlert(title: "للاسف", message: "لا يوجد لقاحات متاحه لعرضها :(")
            }else{
                self.vaccineCollectionView.reloadData()
            }
        }
    }
    func setCellSize(){
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScale)
        let cellHeight = floor(screenSize.height * cellScale)
        let insetX = (view.bounds.width - cellWidth) / 2.0
        let insetY = (view.bounds.height - cellHeight) / 2.0
        let layout = vaccineCollectionView!.collectionViewLayout as!
        UICollectionViewFlowLayout
        layout.itemSize = CGSize (width: cellWidth, height: cellHeight)
        vaccineCollectionView.contentInset = UIEdgeInsets (top: insetY, left: insetX, bottom:insetY, right: insetX)
    }
    func goToVaccineDetails(indesPath: IndexPath){
        let vaccineDetails = VaccineDetailsViewController.instantiate()
        vaccineDetails.myVaccine = arrOfVaccines[indesPath.row]
        vaccineDetails.randomNum = self.randomNum
        self.present(vaccineDetails, animated: true)
    }
}
//MARK: - extension UICollectionViewDelegate,UICollectionViewDataSource
extension VaccineCollectionViewController: UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrOfVaccines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = vaccineCollectionView.dequeueReusableCell(withReuseIdentifier: "VaccineCollectionViewCell", for: indexPath)as! VaccineCollectionViewCell
        let vaccineItem = arrOfVaccines[indexPath.row]
        
        cell.setUpCell(vaccineItem: vaccineItem , random: self.randomNum)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(arrOfVaccines[indexPath.row].scientific_name)
        goToVaccineDetails(indesPath: indexPath)
        
    }
    // هنا عشان اخلي السيل لما اجي اعمل اسكرول تتوسطن ف النص
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.vaccineCollectionView?.collectionViewLayout as!
        UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width +
        layout.minimumLineSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) /
        cellWidthIncludingSpacing
        let roundedIndex = round (index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing -
                         scrollView.contentInset.left, y: scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}
