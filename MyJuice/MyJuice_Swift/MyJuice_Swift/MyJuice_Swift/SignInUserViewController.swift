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


class SignInUserViewController: UIViewController {
    
    var userProfile : NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check facebook accessToken
        if let accessToken = AccessToken.current {
            // User is logged in, use 'accessToken' here.
            
            print("もうしてるよ.")
            print(accessToken)
        }
        
        // Add a custom login button to your app  #3B5997
        let myLoginButton = UIButton(type:.custom)
        let fbcolor:UIColor = #colorLiteral(red: 0.231372549, green: 0.3490196078, blue: 0.5921568627, alpha: 1)
        myLoginButton.backgroundColor = fbcolor
       // (red:0.59, green:0.89, blue:1.51, alpha:1.0)//#colorLiteral

        myLoginButton.frame = CGRect(x:20, y:20, width:330, height:60);
        myLoginButton.layer.cornerRadius = 2.0
        myLoginButton.setTitle("Sign In with Facebook", for: .normal)
        
        // Handle clicks on the button
        myLoginButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
        
        // Add the button to the view
        view.addSubview(myLoginButton)

        
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
                            
                            
                            
                            
                            //after login, gonna go to map setting
                            let SelectAddressViewController: SelectAddressViewController = self.storyboard?.instantiateViewController(withIdentifier: "SelectAddressView") as! SelectAddressViewController
                            
                            let navi = UINavigationController(rootViewController: SelectAddressViewController)
                            // setting animation
                            navi.modalTransitionStyle = .crossDissolve
                            self.present(navi, animated: true, completion: nil)
                            
                            
                            
                            
                            
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


extension UIColor {
    class var theme: UIColor { return #colorLiteral(red: 0.4274509804, green: 0.7568627451, blue: 0.6196078431, alpha: 1) }
    class var notification: UIColor { return #colorLiteral(red: 1, green: 0.4666666667, blue: 0, alpha: 1) }
    class var negative: UIColor { return #colorLiteral(red: 0.9843137255, green: 0.4588235294, blue: 0.4588235294, alpha: 1) }
    class var darkBackground: UIColor { return #colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1725490196, alpha: 1) }
    class var darkLightBackground: UIColor { return #colorLiteral(red: 0.3401621282, green: 0.3401621282, blue: 0.3401621282, alpha: 1) }
}



