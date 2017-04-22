//
//  AccountViewController.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/04/18.
//  Copyright © 2017年 shinji. All rights reserved.
//

import UIKit
import Firebase

class AccountViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("AccountViewController")
        
        
        //signout
//        let firebaseAuth = FIRAuth.auth()
//        do {
//            try firebaseAuth?.signOut()
//        } catch let signOutError as NSError {
//            print ("Error signing out: %@", signOutError)
//        }
  
        
        
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
    
    
    
    
}

