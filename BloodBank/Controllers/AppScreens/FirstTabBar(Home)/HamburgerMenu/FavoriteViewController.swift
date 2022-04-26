//
//  FavoriteViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 23/04/2022.
//

import UIKit

class FavoriteViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var favoriteTableView: UITableView!
    //MARK: - Vars
    let navBar = NavigationBar()
    
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.favoriteTableView.register(UINib(nibName: "favoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "favoriteTableViewCell")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpDesign()
    }
    //MARK: - private functions
    private func setUpDesign(){
        navBar.setNavBar(myView: self, title: "Favorite".Localized(), viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor, forgroundTitle: UIColor.forgroundTitle, bacgroundView: UIColor.backgroundView)
    }
    
    //MARK: - Actions
    

}
//MARK: - UITableViewDelegate, UITableViewDataSource
extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: "favoriteTableViewCell", for: indexPath)as! favoriteTableViewCell
        return cell
    }
    //for animations
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animate(withDuration: 0.35) {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
    }
    
    
}
