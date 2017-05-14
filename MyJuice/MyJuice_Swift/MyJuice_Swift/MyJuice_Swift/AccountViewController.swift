//
//  AccountViewController.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/04/18.
//  Copyright © 2017年 shinji. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let cellId = "cellId"
    var tableView: UITableView  =   UITableView()
    let navTitle = ["Profile","Payment Cards","Addresses","Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Account"
        print("AccountViewController")
        let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.height
        
        tableView.frame         =   CGRect(x: 0, y: statusBarHeight+navigationBarHeight, width: self.view.frame.width, height: 260)
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
  
        checkIfUserIsLoggedIn()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.navigationItem.title = "Accout"
    
    }
    
    
    func checkIfUserIsLoggedIn(){
        
        if FIRAuth.auth()?.currentUser != nil {
            // if already login
            print("login!!!!!!💦")
                        
//            let AccountDetailViewController: AccountDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "AccountDetailView") as! AccountDetailViewController
//            let navi = UINavigationController(rootViewController: AccountDetailViewController)
//            navi.modalTransitionStyle = .crossDissolve
//            present(navi, animated: true, completion: nil)
            
            
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
        return navTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style:.subtitle, reuseIdentifier:cellId)
        cell.textLabel?.text = navTitle[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if(indexPath.row == 0){
            let nextVC: UIViewController = ProfileViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
        }else if(indexPath.row == 1){
            let nextVC: UIViewController = PaymentViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
        }else if(indexPath.row == 2){
            let nextVC: UIViewController = AddressesViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
        }else if(indexPath.row == 3){
            let firebaseAuth = FIRAuth.auth()
            do {
                try
                    firebaseAuth?.signOut()
                print("logout")
                if FIRAuth.auth()?.currentUser != nil {
                    print("still there?")
                }else{
                    
                    let SignInViewController: SignInViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignInView") as! SignInViewController
                    let navi = UINavigationController(rootViewController: SignInViewController)
                    navi.modalTransitionStyle = .crossDissolve
                    present(navi, animated: true, completion: nil)
                }
                
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
        
        //[no storyborad]
//        let nextVC: UIViewController = ProfileViewController()
//        
//        let navi = UINavigationController(rootViewController: nextVC)
//        navi.modalTransitionStyle = .crossDissolve
//        present(navi, animated: true, completion: nil)
//
        
        
        // Should I implement to call each Controller at each time?
//        let className:String = navTitle[indexPath.row]+"ViewController"
//        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String;
//        let cls: AnyClass = NSClassFromString("\(namespace).\(className)")!;
//        let myclass = cls as! UIViewController.Type
//        let instance = myclass.init()
//        self.navigationController?.pushViewController(instance, animated: true)
//        
        
        
    }
    
    
}


