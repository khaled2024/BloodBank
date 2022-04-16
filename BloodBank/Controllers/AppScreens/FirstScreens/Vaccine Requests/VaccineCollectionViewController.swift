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
    @IBOutlet weak var vaccineCollectionView: UICollectionView!
    let navBar = NavigationBar()
    var vaccineItem = [VaccineItem]()
    let cellScale: CGFloat = 0.6
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        vaccineCollectionView.delegate = self
        vaccineCollectionView.dataSource = self
        
        vaccineItem.append(VaccineItem(imageVaccine: UIImage(named: "f1")!, titleVaccine: "لقاح سينوفارم", subTitleVaccine: "كورونافاك",scienceVaccineName: "الصين",tradeVaccineName: "جونسون",vaccineorigin: "ناقل فيروسي غير متكرر" , vaccineCountry: "الصين",packagePrice: 100,packageNumber: 3,totalPrice: 400))
        vaccineItem.append(VaccineItem(imageVaccine: UIImage(named: "f2")!, titleVaccine: "لقاح سينوفارم", subTitleVaccine: "كورونافاك",scienceVaccineName: "الصين",tradeVaccineName: "جونسون",vaccineorigin: "ناقل فيروسي غير متكرر" , vaccineCountry: "الصين",packagePrice: 100,packageNumber: 3,totalPrice: 400))
        vaccineItem.append(VaccineItem(imageVaccine: UIImage(named: "f3")!, titleVaccine: "لقاح سينوفارم", subTitleVaccine: "كورونافاك",scienceVaccineName: "الصين",tradeVaccineName: "جونسون",vaccineorigin: "ناقل فيروسي غير متكرر" , vaccineCountry: "الصين",packagePrice: 100,packageNumber: 3,totalPrice: 400))
        vaccineItem.append(VaccineItem(imageVaccine: UIImage(named: "f4")!, titleVaccine: "لقاح سينوفارم", subTitleVaccine: "كورونافاك",scienceVaccineName: "الصين",tradeVaccineName: "جونسون",vaccineorigin: "ناقل فيروسي غير متكرر" , vaccineCountry: "الصين",packagePrice: 100,packageNumber: 3,totalPrice: 400))
        vaccineItem.append(VaccineItem(imageVaccine: UIImage(named: "f5")!, titleVaccine: "لقاح سينوفارم", subTitleVaccine: "كورونافاك",scienceVaccineName: "الصين",tradeVaccineName: "جونسون",vaccineorigin: "ناقل فيروسي غير متكرر" , vaccineCountry: "الصين",packagePrice: 100,packageNumber: 3,totalPrice: 400))
        vaccineItem.append(VaccineItem(imageVaccine: UIImage(named: "f6")!, titleVaccine: "لقاح سينوفارم", subTitleVaccine: "كورونافاك",scienceVaccineName: "الصين",tradeVaccineName: "جونسون",vaccineorigin: "ناقل فيروسي غير متكرر" , vaccineCountry: "الصين",packagePrice: 100,packageNumber: 3,totalPrice: 400))
        vaccineItem.append(VaccineItem(imageVaccine: UIImage(named: "f7")!, titleVaccine: "لقاح سينوفارم", subTitleVaccine: "كورونافاك",scienceVaccineName: "الصين",tradeVaccineName: "جونسون",vaccineorigin: "ناقل فيروسي غير متكرر" , vaccineCountry: "الصين",packagePrice: 100,packageNumber: 3,totalPrice: 400))
        vaccineItem.append(VaccineItem(imageVaccine: UIImage(named: "f8")!, titleVaccine: "لقاح سينوفارم", subTitleVaccine: "كورونافاك",scienceVaccineName: "الصين",tradeVaccineName: "جونسون",vaccineorigin: "ناقل فيروسي غير متكرر" , vaccineCountry: "الصين",packagePrice: 100,packageNumber: 3,totalPrice: 400))
        vaccineItem.append(VaccineItem(imageVaccine: UIImage(named: "f9")!, titleVaccine: "لقاح سينوفارك", subTitleVaccine: "كورونافاك",scienceVaccineName: "الصين",tradeVaccineName: "جونسون",vaccineorigin: "ناقل فيروسي متكرر" , vaccineCountry: "الصين",packagePrice: 100,packageNumber: 3,totalPrice: 500))
        navBar.setNavBar(myView: self, title: "", viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor ,forgroundTitle: UIColor.forgroundTitle, bacgroundView:UIColor.backgroundView)
        setCellSize()
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
        vaccineDetails.myVaccine = vaccineItem[indesPath.row]
        self.present(vaccineDetails, animated: true)
    }
}
//MARK: - extension UICollectionViewDelegate,UICollectionViewDataSource
extension VaccineCollectionViewController: UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vaccineItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = vaccineCollectionView.dequeueReusableCell(withReuseIdentifier: "VaccineCollectionViewCell", for: indexPath)as! VaccineCollectionViewCell
        let vaccineItem = vaccineItem[indexPath.row]
        cell.setUpCell(vaccineItem: vaccineItem)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(vaccineItem[indexPath.row].titleVaccine)
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
