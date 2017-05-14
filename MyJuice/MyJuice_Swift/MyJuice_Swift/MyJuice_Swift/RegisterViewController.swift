//
//  RegisterViewController.swift
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


class RegisterViewController: UIViewController {
    
    let inputsContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    
    let firstnameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "First Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let nameSeparatorView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r:237,g:237,b:237)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lastnameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Last Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let lnameSeparatorView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r:237,g:237,b:237)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocapitalizationType = UITextAutocapitalizationType.none
        return tf
    }()
    
    let emailSeparatorView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r:237,g:237,b:237)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let myLoginButton:UIButton = {
        let btn = UIButton(type:.custom)
        let fbcolor:UIColor = #colorLiteral(red: 0.231372549, green: 0.3490196078, blue: 0.5921568627, alpha: 1)
        btn.backgroundColor = fbcolor
//        btn.frame = CGRect(x:20, y:20, width:330, height:50);
        btn.layer.cornerRadius = 4.0
        btn.setTitle("Connect with Facebook", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        return btn
    }()
    
    let createAccountButton:UIButton = {
        let btn = UIButton(type:.custom)
        let fbcolor:UIColor = #colorLiteral(red: 0.9647058824, green: 0.8, blue: 0.1834138991, alpha: 1)
        btn.backgroundColor = fbcolor
//        btn.frame = CGRect(x:20, y:20, width:330, height:50);
        btn.layer.cornerRadius = 4.0
        btn.setTitle("Create Account", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(createButtonClicked), for: .touchUpInside)
        return btn
    }()
    
    var ref: FIRDatabaseReference!
    var userProfile : NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r:237,g:237,b:237)
        
        let mailtext = UILabel(frame: CGRect(x:0, y:90, width:self.view.frame.width, height:60))
        mailtext.text = "or with email"
        mailtext.textAlignment = NSTextAlignment.center
        view.addSubview(mailtext)
        
        view.addSubview(inputsContainerView)
        setupInputsContainerView()
        
        view.addSubview(myLoginButton)
        view.addSubview(createAccountButton)
        setupButton()
        
        if FIRAuth.auth()?.currentUser != nil {
            // User is signed in.
            print("Signed In")
        } else {
            // No user is signed in.
            print("nottttttttttttt")
        }
        
    }
    
    func setupButton(){
        
        myLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myLoginButton.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        myLoginButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        myLoginButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        createAccountButton.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        createAccountButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        createAccountButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
    }
    
    func setupInputsContainerView(){
        
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -40).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        inputsContainerView.addSubview(firstnameTextField)
        inputsContainerView.addSubview(nameSeparatorView)
        inputsContainerView.addSubview(lastnameTextField)
        inputsContainerView.addSubview(lnameSeparatorView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTextField)
        
        firstnameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        firstnameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        firstnameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        firstnameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4).isActive = true
        
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: firstnameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        lastnameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        lastnameTextField.topAnchor.constraint(equalTo: firstnameTextField.bottomAnchor).isActive = true
        lastnameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        lastnameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4).isActive = true
        
        lnameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        lnameSeparatorView.topAnchor.constraint(equalTo: lastnameTextField.bottomAnchor).isActive = true
        lnameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        lnameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: lastnameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4).isActive = true
        
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4).isActive = true
        
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
                self.firstnameTextField.text = self.userProfile["first_name"] as! String
                self.lastnameTextField.text  = self.userProfile["last_name"] as! String
                self.emailTextField.text     = self.userProfile["email"] as! String

                
            }
        })
        
    }

    
    func createButtonClicked() {
        
        let email: String! = self.emailTextField.text
        let username: String! = self.firstnameTextField.text
        let lastname: String! = self.lastnameTextField.text
        let password: String! = self.passwordTextField.text
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                if let errCode = FIRAuthErrorCode(rawValue: error!._code) {
                    print("🌟",(error?.localizedDescription)!)
                     self.alert_win(error:(error?.localizedDescription)!)
                    return
                    
                }
            } else {
                print("all good... save user information!!!!!!!")
                //If there is no error...
                self.ref = FIRDatabase.database().reference()
                self.ref.child("users").child(user!.uid).updateChildValues(["email": email])
                self.ref.child("users").child(user!.uid).updateChildValues(["username": username])
                self.ref.child("users").child(user!.uid).updateChildValues(["lastname": lastname])
                self.ref.child("users").child(user!.uid).updateChildValues(["password": password])
                
                
                let alert: UIAlertController = UIAlertController(title: "Created User", message: "Your account has been created successfully!!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { action in
                    self.goNextPage()
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
            }
        }
    }
    
    
    
    func goNextPage(){
        
        self.dismiss(animated: true)
        
        //after login, gonna go to map setting
//        let SelectAddressViewController: SelectAddressViewController = self.storyboard?.instantiateViewController(withIdentifier: "SelectAddressView") as! SelectAddressViewController
//        
//        let navi = UINavigationController(rootViewController: SelectAddressViewController)
//        // setting animation
//        navi.modalTransitionStyle = .crossDissolve
//        self.present(navi, animated: true, completion: nil)
        
    }
    
    func alert_win(error:String){
        
        let alert: UIAlertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            // something
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)

    }
    
    
    
    
}



