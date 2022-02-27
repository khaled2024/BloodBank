//
//  OnboardingViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 15/12/2021.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    //MARK: - outlets
    @IBOutlet weak var PageController: UIPageControl!
    @IBOutlet weak var NextBtn: UIButton!
    @IBOutlet weak var CollectionView: UICollectionView!
    //MARK: - variables
    private let storageManager = StorageManager()
    var SlideArray: [OnboardingSlide] = []
    var currentPage = 0 {
        didSet{
            PageController.currentPage = currentPage
            if currentPage == SlideArray.count - 1{
                self.NextBtn.setTitle("Get Started", for: .normal)
            }else{
                self.NextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    //MARK: - func lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateFlag()
        setUp()
        PageController.numberOfPages = SlideArray.count
    }
    //MARK: - private functions
    private func setUp(){
        CollectionView.delegate = self
        CollectionView.dataSource = self
        SlideArray = [
            OnboardingSlide(title: SlidesArray.title1, description:          SlidesArray.description1, Image: UIImage(named: "1")!),
            OnboardingSlide(title: SlidesArray.title2, description: SlidesArray.description2, Image: UIImage(named: "2")!),
            OnboardingSlide(title: SlidesArray.title3, description: SlidesArray.description3, Image: UIImage(named: "3")!)]
    }
    private func updateFlag(){
        storageManager.setOnboardingSeen()
    }
    //MARK: - Actions
    @IBAction func NextBtnTapped(_ sender: UIButton) {
        if currentPage == SlideArray.count - 1 {
            let controller = storyboard?.instantiateViewController(withIdentifier: Identifier.HomeNC) as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            self.present(controller, animated: true, completion: nil)
            
            //            let storyboard = UIStoryboard(name: "StartingSB", bundle: nil)
            //            let vc = storyboard.instantiateViewController(withIdentifier: "HomeNC")as! UINavigationController
            //            vc.modalPresentationStyle = .fullScreen
            //            vc.modalTransitionStyle = .flipHorizontal
            //            self.present(vc, animated: true, completion: nil)
            
            
        }else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            CollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

//MARK: - Extensions UiCollectionView
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SlideArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.CollectionCell, for: indexPath) as! OnboardingCollectionViewCell
        cell.setUp(slide: SlideArray[indexPath.row])
        print(indexPath.row)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height )
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        print(width)
        currentPage = Int(scrollView.contentOffset.x / width)
        print(scrollView.contentOffset.x)
    }
}
