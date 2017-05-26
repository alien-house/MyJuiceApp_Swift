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
        let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.height
        
        tableView.frame         =   CGRect(x: 0, y: statusBarHeight+navigationBarHeight, width: self.view.frame.width, height: 260)
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        print("🎧")
        //signout
//        let firebaseAuth = FIRAuth.auth()
//        do {
//            try firebaseAuth?.signOut()
//        } catch let signOutError as NSError {
//            print ("Error signing out: %@", signOutError)
//        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.navigationItem.title = "Accout"
        checkIfUserIsLoggedIn()
        
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
            
            
            let alert: UIAlertController = UIAlertController(title: "Register/Sign In", message: "Please register your account or sign in", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { action in
                
                let SignInViewController: SignInViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignInView") as! SignInViewController
                
                let navi = UINavigationController(rootViewController: SignInViewController)
                // setting animation
                navi.modalTransitionStyle = .crossDissolve
                self.present(navi, animated: true, completion: nil)
                
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default) { action in
                print("Cancel")
                self.tabBarController!.selectedIndex = 0
            }
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            
            
            
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
            
            
            
            let alert: UIAlertController = UIAlertController(title: "Logout", message: "Do you really want to logout?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Yes", style: .default) { action in
                
                
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
                        self.present(navi, animated: true, completion: nil)
                    }
                    
                } catch let signOutError as NSError {
                    print ("Error signing out: %@", signOutError)
                }
                
                
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default) { action in
                print("Cancel")
            }
            
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            
            
            
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


