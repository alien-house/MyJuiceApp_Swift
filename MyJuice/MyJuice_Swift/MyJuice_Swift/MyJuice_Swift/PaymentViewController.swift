//
//  PaymentViewController.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/05/06.
//  Copyright © 2017年 shinji. All rights reserved.
//

import UIKit
import Firebase

class PaymentViewController: UIViewController, UITextFieldDelegate {
    var txtfield: UITextField!
    var ref: FIRDatabaseReference!
    var ccNumber:String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Credit Card Number"
        view.backgroundColor = UIColor(r:255,g:255,b:255)
//        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.barButtonItemClicked)), animated: true)
//        

        txtfield = UITextField(frame: CGRect(x: 10, y: 90, width: 230, height: 30))
        txtfield.delegate = self
        txtfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEndOnExit)
        self.view.addSubview(txtfield)
        
        if FIRAuth.auth()?.currentUser != nil {
            
            ref = FIRDatabase.database().reference()
            
            let userID = FIRAuth.auth()?.currentUser?.uid
            ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                self.ccNumber = value?["creditcard"] as! String
                self.txtfield.text = self.ccNumber
            }) { (error) in
                print(error.localizedDescription)
            }
            
        }else{
            print("Need login")
        }

    }
    
    func textFieldDidChange(_ textField: UITextField) {
        print("😄😄","changed")
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                print("😄","changed")
                self.ref.child("users").child(user.uid).updateChildValues(["creditcard": self.txtfield.text!])
            } else {
                print("nothing")
            }
        }
    }

    func barButtonItemClicked(){
        print("😏")
    }


}
