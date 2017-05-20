//
//  ProfileViewController.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/05/01.
//  Copyright © 2017年 shinji. All rights reserved.
//

import UIKit
import Firebase

//@objc(ProfileViewController)

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    let cellId = "cellId"
    var tableView: UITableView  =   UITableView()
    let navTitleArray:NSMutableArray = []
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r:255,g:255,b:255)
        
//        let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        
        tableView.frame         =   CGRect(x: 0, y: 0, width: self.view.frame.width, height: 260)
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.allowsSelection = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        //button.addTarget(self, action: #selector(self.onClick(_:)), for: .touchUpInside)
//        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.goBefore))]
        
        
        ///============
        
        if FIRAuth.auth()?.currentUser != nil {
            
            ref = FIRDatabase.database().reference()
            
            let userID = FIRAuth.auth()?.currentUser?.uid
            ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                let username = value?["username"] as? String ?? ""
                let lastname = value?["lastname"] as? String ?? ""
                let email = value?["email"] as? String ?? ""
                self.navTitleArray.add(username)
                self.navTitleArray.add(lastname)
                self.navTitleArray.add(email)
                self.tableView.reloadData()
                
            }) { (error) in
                print(error.localizedDescription)
            }

        }else{
            print("Need login")
        }
                ///============
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Edit Profile"
    }
    
    
    func goBefore() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func saveData(str: String){
        
        // Keyを指定して保存
//        userDefaults.set(str, forKey: "DataStore")
//        userDefaults.synchronize()
        
    }
    
    func readData() -> String {
        // Keyを指定して読み込み
//        let str: String = userDefaults.object(forKey: "DataStore") as! String
        
//        return str
        return "s"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.navTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style:.subtitle, reuseIdentifier:cellId)
        let txtfield = UITextField(frame: CGRect(x: 10, y: 10, width: 200, height: 30))
        txtfield.tag = indexPath.row
        txtfield.delegate = self
        txtfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEndOnExit)
        txtfield.text = self.navTitleArray[indexPath.row] as? String
        cell.addSubview(txtfield)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                switch(textField.tag){
                case 0:
                    self.ref.child("users").child(user.uid).updateChildValues(["username": textField.text!])
                    break
                case 1:
                    self.ref.child("users").child(user.uid).updateChildValues(["lastname": textField.text!])
                    break
                case 2:
                    let cuser = FIRAuth.auth()?.currentUser
                    // needed re auth
//                    var credential: FIRAuthCredential
//                    let credential = FIREmailPasswordAuthProvider.credentialWithEmail(email, password: password)

                    // Prompt the user to re-provide their sign-in credentials
//                    
//                    cuser?.reauthenticate(with: credential) { error in
//                        if let error = error {
//                            
////                            if let cuser = FIRAuth.auth()?.currentUser{
////                                cuser.updateEmail(textField.text!, completion: { error in
////                                    if let error = error {
////                                        print(error.localizedDescription)
////                                        
////                                    } else {
////                                        self.ref.child("users").child(user.uid).updateChildValues(["email": textField.text!])
////                                    }
////                                })
////                            }
//                            
//                            
//                        } else {
//                            // User re-authenticated.
//                        }
//                    }
                    
                    
                    
                    break
                    
                default:
                    
                    break
                }
                
            } else {
                print("😄","nothing")
            }
        }
        print("changeddd"+"👽")
    }
}
