//
//  SignInViewController.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/04/03.
//  Copyright © 2017年 shinji. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController  {
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    
    var item = "kikiki"
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
//        loginButton.center = view.center
//        view.addSubview(loginButton)
        
        
        self.ref = FIRDatabase.database().reference()
        
        //save the data
//        var username:String = "oooooooo"
//        self.ref.child("youandi").setValue(["username": username])
    }
    
//    func setup(){
//        
//        let viewController = viewControllerForSegmentIndex(0)
//        self.addChildViewController(viewController)
//        viewController.view.frame = self.view.bounds
//        
//        self.vcView.addSubview(SignVC.view)
//        self.vcView.addSubview(CreateVC.view)
//        NSLog("%@",SignVC.view);
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    @IBAction func segmentChange(_ sender: UISegmentedControl) {
        
        if(sender.selectedSegmentIndex == 0){
            
            UIView.animate(withDuration: 0.5, animations: { 
                self.leftView.alpha = 0.0
                self.rightView.alpha = 1.0
            })
        }else{
            
            UIView.animate(withDuration: 0.5, animations: {
                self.leftView.alpha = 1.0
                self.rightView.alpha = 0.0
            })
        }
        
    }
    
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
//        nextViewController.foo = bar
        print("☀️")
        let controller = self.presentingViewController as? SignInViewController
        self.dismiss(animated: true, completion: {
            controller?.item = "kokoko"
            print(self.parent?.childViewControllers)
//            self.parent.yourVariable = 0
        })
    }
    
    
}

