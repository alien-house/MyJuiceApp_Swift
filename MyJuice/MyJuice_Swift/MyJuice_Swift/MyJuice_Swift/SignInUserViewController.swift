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
    
    let inputsContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.autocapitalizationType = UITextAutocapitalizationType.none
        tf.translatesAutoresizingMaskIntoConstraints = false
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
        btn.setTitle("Sign In with Facebook", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        return btn
    }()
    
    let signInAccountButton:UIButton = {
        let btn = UIButton(type:.custom)
        let fbcolor:UIColor = #colorLiteral(red: 0.9648040926, green: 0.4545456292, blue: 0.4881974511, alpha: 1)
        btn.backgroundColor = fbcolor
        //        btn.frame = CGRect(x:20, y:20, width:330, height:50);
        btn.layer.cornerRadius = 4.0
        btn.setTitle("Sign In Account", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
        return btn
    }()
    
    struct User {
        let name: String = "name"
        let email: String = "email"
    }

    var user = User()
    var userProfile : NSDictionary!
    let userDefaults = UserDefaults.standard
    
//    @IBOutlet weak var email_input: UITextField!
//    @IBOutlet weak var password_input: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r:237,g:237,b:237)
        
        let mailtext = UILabel(frame: CGRect(x:0, y:90, width:self.view.frame.width, height:60))
        mailtext.text = "or with email"
        mailtext.textAlignment = NSTextAlignment.center
        view.addSubview(mailtext)
        
        // check facebook accessToken
        if let accessToken = AccessToken.current {
            // User is logged in, use 'accessToken' here.
            print("もうしてるよ.")
            print(accessToken)
        }
        
        view.addSubview(inputsContainerView)
        setupInputsContainerView()
        view.addSubview(myLoginButton)
        view.addSubview(signInAccountButton)
        setupButton()
        
        
        userDefaults.register(defaults: ["DataStore": "default"])
//        saveData(str: "mushimushi")
//        print(readData())
    }
    
    
    func saveData(str: String){
        
        // Keyを指定して保存
//        self.user = User(name: "夏目漱石",email:"ucyuujinoco@gmail.com")
        
        
        userDefaults.set("夏目漱石", forKey: user.name)
        userDefaults.synchronize()
        
    }
    func readData() -> String {
        // Keyを指定して読み込み
        let str: String = userDefaults.object(forKey: user.name) as! String
        
        return str
    }
    
    func setupButton(){
        
        myLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myLoginButton.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        myLoginButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        myLoginButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        signInAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signInAccountButton.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        signInAccountButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        signInAccountButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
    }
    
    func setupInputsContainerView(){
        
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -40).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTextField)
        
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2).isActive = true
        
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2).isActive = true
        
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
                print("90900090909090909")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                print("=-=-====--===-=")
                print("credential?!")
                print(credential)
                
                
                //Firebase login
                FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                    if error != nil {
                        print("error!!!!!!!")
                        self.alert_win(error:(error?.localizedDescription)!)
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
                            
                            
                            self.goNextPage()
                            
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
    
    
    func signInButtonClicked(){
        
        let email: String! = self.emailTextField.text
        let password: String! = self.passwordTextField.text
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            
            if error == nil{
                print("suceess!!")
                self.goNextPage()
            }else{
                self.alert_win(error: (error?.localizedDescription)!)
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
    
    
    func logout(){
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
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


extension UIColor {
    class var theme: UIColor { return #colorLiteral(red: 0.4274509804, green: 0.7568627451, blue: 0.6196078431, alpha: 1) }
    class var notification: UIColor { return #colorLiteral(red: 1, green: 0.4666666667, blue: 0, alpha: 1) }
    class var negative: UIColor { return #colorLiteral(red: 0.9843137255, green: 0.4588235294, blue: 0.4588235294, alpha: 1) }
    class var darkBackground: UIColor { return #colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1725490196, alpha: 1) }
    class var darkLightBackground: UIColor { return #colorLiteral(red: 0.3401621282, green: 0.3401621282, blue: 0.3401621282, alpha: 1) }
}



