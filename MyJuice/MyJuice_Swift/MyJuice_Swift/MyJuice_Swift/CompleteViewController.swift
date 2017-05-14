//
//  CompleteViewController.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/05/13.
//  Copyright © 2017年 shinji. All rights reserved.
//

import UIKit

class CompleteViewController: UIViewController {
    
    let topButton:UIButton = {
        let btn = UIButton(type:.custom)
        let fbcolor:UIColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        btn.backgroundColor = fbcolor
        //        btn.frame = CGRect(x:20, y:20, width:330, height:50);
        btn.layer.cornerRadius = 4.0
        btn.setTitle("back to top page", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(topButtonClicked), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let textField:UILabel = UILabel()
        textField.text = "Thnak you so much!"
        textField.frame         =   CGRect(x: 0, y: 100, width: self.view.frame.width, height: 40)
        textField.textAlignment = NSTextAlignment.center
        self.view.addSubview(textField)
        
        view.addSubview(topButton)
        topButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topButton.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 180).isActive = true
        topButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        topButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func topButtonClicked() {

        
        self.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)

//        self.dismiss(animated: true, completion: nil)

        
//        let loginManager = LoginManager()
//        loginManager.logIn([ .publicProfile, .email ], viewController: self) { loginResult in
//            switch loginResult {
//            case .failed(let error):
//                print(error)
//                print("User errorerrorerrorerror login.")
//            case .cancelled:
//                print("User cancelled login.")
//            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
//                print("Logged in!")
//                print(accessToken)
//                print(FBSDKAccessToken.current().tokenString)
//                //
//                print("90900090909090909")
//                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
//                
//                print("=-=-====--===-=")
//                print("credential?!")
//                print(credential)
//                
//                
//                //Firebase login
//                FIRAuth.auth()?.signIn(with: credential) { (user, error) in
//                    if error != nil {
//                        print("error!!!!!!!")
//                        print(error)
//                        self.alert_win(error:(error?.localizedDescription)!)
//                    }else{
//                        
//                        if FIRAuth.auth()?.currentUser != nil {
//                            print("current!!!!!!!")
//                            
//                            let user = FIRAuth.auth()?.currentUser
//                            // The user's ID, unique to the Firebase project.
//                            // Do NOT use this value to authenticate with your backend server,
//                            // if you have one. Use getTokenWithCompletion:completion: instead.
//                            let email = user?.email
//                            let uid = user?.uid
//                            let photoURL = user?.photoURL
//                            
//                            
//                            self.goNextPage()
//                            
//                        }else{
//                            print("no exist!")
//                        }
//                        
//                    }
//                }
//                
//                self.returnUserData()
//            }
//        }
        
    }
    

    


}
