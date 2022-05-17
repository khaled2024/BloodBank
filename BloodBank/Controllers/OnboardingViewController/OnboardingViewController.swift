//
//  OnboardingViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 15/12/2021.
//

import UIKit
// اون بوردينج اسكرين
class OnboardingViewController: UIViewController {
    
    //MARK: - outlets
    @IBOutlet var onboardingView: UIView!
    @IBOutlet weak var PageController: UIPageControl!
    @IBOutlet weak var NextBtn: UIButton!
    @IBOutlet weak var CollectionView: UICollectionView!
    //MARK: - variables
    private let storageManager = StorageManager()
    var SlideArray: [OnboardingSlide] = []
    let currentLang = Locale.current.languageCode
    var currentPage = 0 {
        didSet{
            PageController.currentPage = currentPage
            if currentPage == SlideArray.count - 1{
                self.NextBtn.setTitle("Get Started".Localized().Localized(), for: .normal)
//                self.NextBtn.customTitleLbl(btn: NextBtn, text: "ابدا", fontSize: 17)
            }else{
                self.NextBtn.setTitle("Next".Localized(), for: .normal)
//                self.NextBtn.customTitleLbl(btn: NextBtn, text: "استمرار", fontSize: 17)
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onboardingView.semanticContentAttribute = .forceLeftToRight
        PageController.semanticContentAttribute = .forceLeftToRight
        CollectionView.semanticContentAttribute = .forceLeftToRight
    }
    //MARK: - private functions
    private func setUp(){
        CollectionView.delegate = self
        CollectionView.dataSource = self
        if currentLang == "ar"{
            SlideArray = [
                OnboardingSlide(title: "تحقق من الأهلية", description: "قم بإجراء اختبار سريع للتقييم الذاتي لتعرف إذا كنت لائقًا بما يكفي للتبرع بالدم والإجابة على بعض الأسئلة البسيطة.", Image: UIImage(named: "1")!),
                OnboardingSlide(title: "جدولة موعد", description: "حدد موعدًا للتبرع بالدم بالقطف فتحات التاريخ والوقت المتاحة وفقًا لـمفضلاتك.", Image: UIImage(named: "2")!),
                OnboardingSlide(title: "انشر طلب تبرع بالدم", description: "طلب دم لآلاف المستخدمين من بلدك في بضع خطوات بسيطة.", Image: UIImage(named: "3")!)]
        }else{
            SlideArray = [
                OnboardingSlide(title: "Check Eligibility", description: "Take a quick self assessment test to know if you are fit enough to donate blood by answering a few simple questions." , Image: UIImage(named: "1")!),
                OnboardingSlide(title: "Schedule Appointment", description: "Schedule blood donation by picking available date and time slots according to your preference.", Image: UIImage(named: "2")!),
                OnboardingSlide(title: "Post a Blood Donation Request", description: "Request for blood to thousands of users from your country in a few quick simple steps.", Image: UIImage(named: "3")!)]
        }
    }
    private func updateFlag(){
        storageManager.setOnboardingSeen()
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
    }
    //MARK: - Actions
    @IBAction func NextBtnTapped(_ sender: UIButton) {
        if currentPage == SlideArray.count - 1 {
            let controller = storyboard?.instantiateViewController(withIdentifier: Identifier.HomeNC) as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            self.present(controller, animated: true, completion: nil)
            
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
