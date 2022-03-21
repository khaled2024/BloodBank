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
        navBar.setNavBar(myView: self, title: "تعلم بنفسك", viewController: view, navBarColor: #colorLiteral(red: 0.9845134616, green: 0.9810839295, blue: 0.9719126821, alpha: 1), navBarTintColor: #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1), forgroundTitle: #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1), bacgroundView: #colorLiteral(red: 0.9845134616, green: 0.9810839295, blue: 0.9719126821, alpha: 1))
        //        self.collectionView.cornerRadius  = 25
        
    }
    
    private func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNext), userInfo: nil, repeats: true)
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
