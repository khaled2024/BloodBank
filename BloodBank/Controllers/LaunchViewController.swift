//
//  LaunchViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 02/04/2022.
//

import UIKit

class LaunchViewController: UIViewController {
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.image = UIImage(named: "blood-donation")
        
        return imageView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = self.view.center
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.animate()
        }
    }
    
    private func animate(){
        UIView.animate(withDuration: 1) {
            let size = self.view.frame.size.width * 1.8
            let diffX = size - self.view.frame.size.width
            let diffY =  self.view.frame.size.height - size
            self.imageView.frame = CGRect(x: -(diffX/2), y: diffY/2, width: size, height: size)
        }
        UIView.animate(withDuration: 1,animations:  {
            self.imageView.alpha = 0.0
        } ,completion: { done in
            if done{
                let vc = LoadingViewController()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        })
                       
    }
}

