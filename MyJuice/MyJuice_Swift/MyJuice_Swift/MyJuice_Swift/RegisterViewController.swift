//
//  RegisterViewController.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/04/03.
//  Copyright © 2017年 shinji. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var firstname_input: UITextField!
    @IBOutlet weak var lastname_input: UITextField!
    @IBOutlet weak var email_input: UITextField!
    @IBOutlet weak var password_input: UITextField!
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = UIColor(r:61,g:90,b:151)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        if FIRAuth.auth()?.currentUser != nil {
            // User is signed in.
            print("Signed In")
        } else {
            // No user is signed in.
            print("nottttttttttttt")
            
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func click_create(_ sender: UIButton) {
        print(self.firstname_input)
        
        let email: String! = self.email_input.text
        let username: String! = self.firstname_input.text
        let password: String! = self.password_input.text
        
        
        
        self.alert_win()

        
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            
            if error != nil{
                print(error)
                dump(error)
                return
            }
            self.ref = FIRDatabase.database().reference()
            self.ref.child("users").child(user!.uid).setValue(["email": email])
            self.ref.child("users").child(user!.uid).setValue(["username": username])
            self.ref.child("users").child(user!.uid).setValue(["password": password])
            
            
            
            let changeRequest = user?.profileChangeRequest()
            
            changeRequest?.commitChanges( completion: { error in
                if let error = error {
                    print("Error: \(error)")
                } else {
                    print("Profile updated")
                }
                
                self.ref.child("users").child(user!.uid).setValue(["email": email])
                self.ref.child("users").child(user!.uid).setValue(["username": username])
                self.ref.child("users").child(user!.uid).setValue(["password": password])
                
                
            })
            
        }
        
    }
    
    
    func alert_win(){
        
        
        // アラート表示
        let alert: UIAlertController = UIAlertController(title: "Passwords must be at least 8 character", message: "Please re-enter your password", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            print("Action OK!!")
        }
        alert.addAction(okAction)

    }
    
    
    
    
}



extension UIColor{
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha:1)
    }
}
