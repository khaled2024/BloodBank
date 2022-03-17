//
//  MainViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 28/01/2022.
//

import UIKit
class MainViewController: UIViewController , HambburgerViewControllerDelegate, opacityDelegate{
    //MARK: - Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var humbergerView: UIView!
    @IBOutlet weak var backViewForHumburger: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var slideMenuBtn: UIBarButtonItem!
    
    //for animations
    @IBOutlet weak var scaduleAppointmentView: UIView!
    @IBOutlet weak var donateBloodView: UIView!
    @IBOutlet weak var requestBloodView: UIView!
    @IBOutlet weak var educateYourselfView: UIView!
    
    
    @IBOutlet weak var appointmentImage: UIImageView!
    @IBOutlet weak var donationImage: UIImageView!
    
    @IBOutlet weak var requestImage: UIImageView!
    @IBOutlet weak var educateImage: UIImageView!
    //MARK: - Variables
    var hamburgerViewController: HamburgerViewController?
    var slideIsClicked: Bool = false
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        humbergerView.isHidden = true
        testView.isUserInteractionEnabled = false
        self.testView.layer.opacity = 1
        self.animateScalling()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ]
        self.view.backgroundColor =  #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        animateViews()
        animateImages()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK: -  private functions
    private func animateScalling(){
        UIView.animate(withDuration: 1) {
            self.scaduleAppointmentView.center.x += 13
            self.donateBloodView.center.x += 13
            self.requestBloodView.center.x += 13
            self.educateYourselfView.center.x += 13
        }
    }
    private func animateViews(){
        self.scaduleAppointmentView.alpha = 0
        self.donateBloodView.alpha = 0
        self.requestBloodView.alpha = 0
        self.educateYourselfView.alpha = 0
        self.appointmentImage.alpha = 1
        self.donationImage.alpha = 1
        self.requestImage.alpha = 1
        self.educateImage.alpha = 1
        UIView.animate(withDuration: 1) {
            self.scaduleAppointmentView.alpha = 1
            self.donateBloodView.alpha = 1
            self.requestBloodView.alpha = 1
            self.educateYourselfView.alpha = 1
        }
    }
    private func animateImages(){
        //        let x = appointmentImage.frame.minX - 25
        //        let y = appointmentImage.frame.minY - 25
        //        let width = appointmentImage.frame.width + 50
        //        let height = appointmentImage.frame.height + 50
        UIView.animate(withDuration: 1, delay: 1, options: [.repeat , .autoreverse], animations: {
            //            self.appointmentImage.frame = CGRect(x: x, y: y, width: width, height: height)
            self.appointmentImage.alpha = 0
            self.donationImage.alpha = 0
            self.requestImage.alpha = 0
            self.educateImage.alpha = 0
        }, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "hamburgerSegue"){
            if let controller = segue.destination as? HamburgerViewController{
                self.hamburgerViewController = controller
                self.hamburgerViewController?.delegate = self
                self.hamburgerViewController?.delegate2 = self
            }
        }
    }
    func hideHamburgerMenu() {
        UIView.animate(withDuration: 0.2) {
            self.leading.constant = 5
            self.view.layoutIfNeeded()
        } completion: { status in
            UIView.animate(withDuration: 0.2) {
                self.leading.constant = -280
                self.view.layoutIfNeeded()
            } completion: { status in
                self.humbergerView.isHidden = true
                self.isHamburgerMenuShown = false
                self.testView.isUserInteractionEnabled = false
                self.slideIsClicked = false
            }
        }
    }
    func backViewForHumburgerObacity() {
        self.backViewForHumburger.layer.opacity = 1
        self.scrollView.layer.opacity = 1
        self.testView.layer.opacity = 1
    }
    private func showSlideMenu(){
        UIView.animate(withDuration: 0.1) {
            self.leading.constant = 10
            self.view.layoutIfNeeded()
        } completion: { status in
            UIView.animate(withDuration: 0.1) {
                self.leading.constant = 0
                self.view.layoutIfNeeded()
            } completion: { status in
                self.humbergerView.isHidden = false
                self.backViewForHumburger.layer.opacity = 0.60
                self.testView.isUserInteractionEnabled = true
                self.testView.layer.opacity = 0.60
                self.isHamburgerMenuShown = true
                self.slideIsClicked = true
            }
        }
    }
    // hamburger movment code
    private var isHamburgerMenuShown: Bool = false
    private var beginPoint: CGFloat = 0.0
    private var diffrence:CGFloat = 0.0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(isHamburgerMenuShown){
            if let touch = touches.first{
                let location = touch.location(in: testView)
                beginPoint = location.x
                self.testView.isUserInteractionEnabled = false
                
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(isHamburgerMenuShown){
            if let touch = touches.first{
                let location = touch.location(in: testView)
                let diffFromBeginPoint = beginPoint-location.x
                if (diffFromBeginPoint > 0 && diffFromBeginPoint < 280){
                    self.leading.constant = -diffFromBeginPoint
                    diffrence = diffFromBeginPoint
                    self.testView.layer.opacity = Float(0.60+(0.60*diffFromBeginPoint/280))
                    self.backViewForHumburger.layer.opacity = Float(0.60+(0.60*diffFromBeginPoint/280))
                    //print("diff is - \(diffFromBeginPoint)")
                    self.testView.isUserInteractionEnabled = false
                }
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(isHamburgerMenuShown){
            if (diffrence < 140){
                UIView.animate(withDuration: 0.2) {
                    self.leading.constant = -290
                } completion: { status in
                    self.isHamburgerMenuShown = false
                    self.humbergerView.isHidden = true
                    self.testView.isUserInteractionEnabled = false
                    self.testView.layer.opacity = 1
                    self.scrollView.layer.opacity = 1
                    self.backViewForHumburger.layer.opacity = 1
                    self.slideIsClicked = false
                    
                }
            }else{
                UIView.animate(withDuration: 0.1) {
                    self.leading.constant = -10
                } completion: { status in
                    self.humbergerView.isHidden = true
                    self.testView.isHidden = false
                    self.slideIsClicked = false
                }
            }
        }
    }
    private func BookingApp(){
        let appointmentVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppointmentViewController")as? AppointmentViewController
        navigationController?.pushViewController(appointmentVC!, animated: true)
        self.modalTransitionStyle = .partialCurl
    }
    private func DonateBlood(){
        
        let donateBloodVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DonateBloodViewController")as? DonateBloodViewController
        navigationController?.pushViewController(donateBloodVC!, animated: true)
        self.modalTransitionStyle = .partialCurl
    }
    private func RequestBlood(){
        let requestBloodVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RequestBloodViewController")as? RequestBloodViewController
        navigationController?.pushViewController(requestBloodVC!, animated: true)
        self.modalTransitionStyle = .partialCurl
    }
    private func EducateYourself(){
        let educateYourselfVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EducateYourselfViewController")as? EducateYourselfViewController
        navigationController?.pushViewController(educateYourselfVC!, animated: true)
        self.modalTransitionStyle = .partialCurl
    }
    private func NotificationScreen(){
        let notificationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationViewController")as! NotificationViewController
        navigationController?.pushViewController(notificationVC, animated: true)
        self.modalTransitionStyle = .partialCurl
    }
    //MARK: - Actions
    @IBAction func touchOnScreen(_ sender: UITapGestureRecognizer) {
        hideHamburgerMenu()
        self.testView.layer.opacity = 1
        self.scrollView.layer.opacity = 1
        self.backViewForHumburger.layer.opacity = 1
    }
    @IBAction func barBtnTapped(_ sender: UIBarButtonItem) {
        if self.slideIsClicked == false{
            showSlideMenu()
        }else{
            hideHamburgerMenu()
            self.testView.layer.opacity = 1
            self.scrollView.layer.opacity = 1
            self.backViewForHumburger.layer.opacity = 1
        }
        
    }
    @IBAction func notificationBtnTapped(_ sender: UIBarButtonItem) {
        self.NotificationScreen()
    }
    @IBAction func bookingAppintment(_ sender: UIButton) {
        self.BookingApp()
        
    }
    @IBAction func donateBloodBtnTapped(_ sender: UIButton) {
        self.DonateBlood()
        
    }
    @IBAction func requestBloodBtnTapped(_ sender: UIButton) {
        self.RequestBlood()
    }
    @IBAction func educateYourselfBtnTapped(_ sender: UIButton) {
        self.EducateYourself()
    }
}
