//
//  CreateViewController.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/04/03.
//  Copyright © 2017年 shinji. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

import FacebookCore
import FacebookLogin
import Firebase
import FirebaseAuth


class LeftViewController: UIViewController {
    
    var userProfile : NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check facebook accessToken
        if let accessToken = AccessToken.current {
            // User is logged in, use 'accessToken' here.
            
            print("もうしてるよ.")
            print(accessToken)
        }
        
        
        // Add a custom login button to your app
        let myLoginButton = UIButton(type:.custom)
        myLoginButton.backgroundColor = UIColor.darkGray
        myLoginButton.frame = CGRect(x:0, y:0, width:180, height:40);
        myLoginButton.center = view.center;
//        myLoginTitle.setTitle("My Login Button", forState: .Normal)
        
        // Handle clicks on the button
        myLoginButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
        
        // Add the button to the view
        view.addSubview(myLoginButton)

        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Once the button is clicked, show the login dialog
    func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile, .email ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
                print("User errorerrorerrorerror login.")
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
                print(accessToken)
                print(FBSDKAccessToken.current().tokenString)
                //
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                print("credential?!")
                print(credential)
                
                
                //Firebase login
                FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                    if error != nil {
                        
                        
                    }else{
                        
                        if FIRAuth.auth()?.currentUser != nil {
                            print("current!!!!!!!")
                            
                            let user = FIRAuth.auth()?.currentUser
                            // The user's ID, unique to the Firebase project.
                            // Do NOT use this value to authenticate with your backend server,
                            // if you have one. Use getTokenWithCompletion:completion: instead.
                            let email = user?.email
                            let uid = user?.uid
                            let photoURL = user?.photoURL
                            print(user)
                            print(email)
                            
                        }else{
                            print("no exist!")
                        }
                        
                    }
                }
                
                
                
                
                self.returnUserData()
            }
        }
    }
    
    
    func returnUserData(){
        
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me",
                                                                 parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"])
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            if ((error) != nil)
            {
                // erroe
                print("Error: \(String(describing: error))")
            }
            else
            {
                // putting user data into dictonary
                self.userProfile = result as! NSDictionary
                print(self.userProfile)
                
            }
        })
        
    }
    
    func logout(){
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}
