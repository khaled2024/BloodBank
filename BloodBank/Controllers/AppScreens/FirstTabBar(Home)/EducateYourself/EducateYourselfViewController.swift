//
//  EducateYourselfViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 23/02/2022.
//

import UIKit

class EducateYourselfViewController: UIViewController {
    
    let navBar = NavigationBar()
    let educateArray = EducateTabelArray.educateArray
    let bloodArticel = BloodArticels.bloodArray
    let educateImagesArray = EducateCollectionArray.educateArrayImage
    var timer: Timer?
    var currentCellIndex = 0
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tabelView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDesign()
        setUp()
        startTimer()
    }
    
    //MARK: - private func
    private func setUp(){
        self.tabelView.delegate = self
        self.tabelView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        pageControll.numberOfPages = educateImagesArray.count
    }
    private func setUpDesign(){
        navBar.setNavBar(myView: self, title: "Educate YourSelf".Localized(), viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor, forgroundTitle: UIColor.forgroundTitle, bacgroundView: UIColor.backgroundView)
        
    }
    
    private func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(moveToNext), userInfo: nil, repeats: true)
    }
    @objc func moveToNext(){
        if currentCellIndex < educateImagesArray.count - 1{
            self.currentCellIndex += 1
        }else{
            self.currentCellIndex  = 0
        }
        self.collectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageControll.currentPage = currentCellIndex
    }
    private func goToDetails(indexPath: IndexPath){
        let controller = EducateDetailsViewController.instantiate()
        self.navigationController?.pushViewController(controller, animated: true)
        controller.titleNavBar = educateArray[indexPath.row]
        controller.bloodArticels = bloodArticel[indexPath.row]
    }
}
//MARK: - extension
extension EducateYourselfViewController:
    UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return educateArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = educateArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.goToDetails(indexPath: indexPath)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
extension EducateYourselfViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return educateImagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "educateCell", for: indexPath)as! EducateCollectionViewCell
        cell.imageView.image = educateImagesArray[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
