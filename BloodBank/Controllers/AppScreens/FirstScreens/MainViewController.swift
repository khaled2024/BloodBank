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
    var hamburgerViewController: HamburgerViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        humbergerView.isHidden = true
        testView.isUserInteractionEnabled = false
        self.testView.layer.opacity = 1
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ]
        self.view.backgroundColor =  #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
    }
    
    
    //MARK: -  private functions
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
            }
        }
    }
    func backViewForHumburgerObacity() {
        self.backViewForHumburger.layer.opacity = 1
        self.scrollView.layer.opacity = 1
        self.testView.layer.opacity = 1
    }
    func showSlideMenu(){
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
                    print("diff is - \(diffFromBeginPoint)")
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
                    
                }
            }else{
                UIView.animate(withDuration: 0.1) {
                    self.leading.constant = -10
                } completion: { status in
                    self.humbergerView.isHidden = true
                    self.testView.isHidden = false
                }
            }
        }
    }
    //MARK: - Actions
    @IBAction func touchOnScreen(_ sender: UITapGestureRecognizer) {
        hideHamburgerMenu()
        self.testView.layer.opacity = 1
        self.scrollView.layer.opacity = 1
        self.backViewForHumburger.layer.opacity = 1
    }
    @IBAction func barBtnTapped(_ sender: UIBarButtonItem) {
        showSlideMenu()
    }
    @IBAction func notificationBtnTapped(_ sender: UIBarButtonItem) {
        let notificationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationViewController")as! NotificationViewController
        //        self.present(notificationVC, animated: true, completion: nil)
        navigationController?.pushViewController(notificationVC, animated: true)
        self.modalTransitionStyle = .partialCurl
    }
    @IBAction func bookingAppintment(_ sender: UIButton) {
        let appointmentVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppointmentViewController")as? AppointmentViewController
        navigationController?.pushViewController(appointmentVC!, animated: true)
        self.modalTransitionStyle = .partialCurl
    }
    @IBAction func donateBloodBtnTapped(_ sender: UIButton) {
        let donateBloodVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DonateBloodViewController")as? DonateBloodViewController
        navigationController?.pushViewController(donateBloodVC!, animated: true)
        self.modalTransitionStyle = .partialCurl
    }
    @IBAction func requestBloodBtnTapped(_ sender: UIButton) {
        let requestBloodVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RequestBloodViewController")as? RequestBloodViewController
        navigationController?.pushViewController(requestBloodVC!, animated: true)
        self.modalTransitionStyle = .partialCurl
    }
    @IBAction func educateYourselfBtnTapped(_ sender: UIButton) {
        let educateYourselfVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EducateYourselfViewController")as? EducateYourselfViewController
        navigationController?.pushViewController(educateYourselfVC!, animated: true)
        self.modalTransitionStyle = .partialCurl
    }
}
