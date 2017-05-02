//
//  AccountViewController.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/04/18.
//  Copyright © 2017年 shinji. All rights reserved.
//

import UIKit
import Firebase

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let cellId = "cellId"
    var tableView: UITableView  =   UITableView()
    let navTitle = ["Profile","Payment Cards","Addresses"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("AccountViewController")
        let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        
        tableView.frame         =   CGRect(x: 0, y: statusBarHeight, width: self.view.frame.width, height: 260)
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        //signout
//        let firebaseAuth = FIRAuth.auth()
//        do {
//            try firebaseAuth?.signOut()
//        } catch let signOutError as NSError {
//            print ("Error signing out: %@", signOutError)
//        }
  
//        checkIfUserIsLoggedIn()
        
    }
    
    
    
    func checkIfUserIsLoggedIn(){
        
        if FIRAuth.auth()?.currentUser != nil {
            // if already login
            
            //[no storyborad]
            //            let nextVC: UIViewController = AccountDetailViewController()
            //            nextVC.modalTransitionStyle = UIModalTransitionStyle.partialCurl
            //            self.present(nextVC, animated: true, completion: nil)
                        
            let AccountDetailViewController: AccountDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "AccountDetailView") as! AccountDetailViewController
            
            let navi = UINavigationController(rootViewController: AccountDetailViewController)
            // setting animation
            navi.modalTransitionStyle = .crossDissolve
            present(navi, animated: true, completion: nil)
            
            
        }else{
            // without login
            
            let SignInViewController: SignInViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignInView") as! SignInViewController
            
            let navi = UINavigationController(rootViewController: SignInViewController)
            // setting animation
            navi.modalTransitionStyle = .crossDissolve
            present(navi, animated: true, completion: nil)
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style:.subtitle, reuseIdentifier:cellId)
        cell.textLabel?.text = navTitle[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //[no storyborad]
        let nextVC: UIViewController = ProfileViewController()
        
        let navi = UINavigationController(rootViewController: nextVC)
        navi.modalTransitionStyle = .crossDissolve
        present(navi, animated: true, completion: nil)
        
        
    }
    
    
}


