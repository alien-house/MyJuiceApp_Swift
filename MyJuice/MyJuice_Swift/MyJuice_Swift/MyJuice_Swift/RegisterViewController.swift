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

struct LoginErrorCode {
    static let INVALID_EMAIL = "Invalid email, please provide a real email address";
    static let WRONG_PASSWORD = "Wrong Password, Please Try Again";
    static let PROBLEM_CONNECTING = "Problem Connecting to Database. Please Try Later";
    static let USER_NOT_FOUND = "User Not Found, Please Register";
    static let EMAIL_ALREADY_IN_USE = "Email Already In Use, Please Use Different Email";
    static let WEAK_PASSWORD = "Password Should Be At Least 6 Characters";
}

class RegisterViewController: UIViewController {
    
    let inputsContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let nameSeparatorView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r:220,g:220,b:220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @IBOutlet weak var firstname_input: UITextField!
    @IBOutlet weak var lastname_input: UITextField!
    @IBOutlet weak var email_input: UITextField!
    @IBOutlet weak var password_input: UITextField!
    var ref: FIRDatabaseReference!
    var userProfile : NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor(r:61,g:90,b:151)
        
        let myLoginButton = UIButton(type:.custom)
        let fbcolor:UIColor = #colorLiteral(red: 0.231372549, green: 0.3490196078, blue: 0.5921568627, alpha: 1)
        myLoginButton.backgroundColor = fbcolor
        myLoginButton.frame = CGRect(x:20, y:20, width:330, height:60);
        myLoginButton.layer.cornerRadius = 2.0
        myLoginButton.setTitle("Connect with Facebook", for: .normal)
        
        // Handle clicks on the button
        myLoginButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
        view.addSubview(myLoginButton)
        
        let mailtext = UILabel(frame: CGRect(x:0, y:90, width:self.view.frame.width, height:60))
        mailtext.text = "or with email"
        mailtext.textAlignment = NSTextAlignment.center
        view.addSubview(mailtext)
        
        
        view.addSubview(inputsContainerView)
        setupInputsContainerView()
        
        if FIRAuth.auth()?.currentUser != nil {
            // User is signed in.
            print("Signed In")
        } else {
            // No user is signed in.
            print("nottttttttttttt")
        }
        
    }
    
    func setupInputsContainerView(){
        
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -40).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeparatorView)
        
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4).isActive = true
        
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor)
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor)
        nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor)
        
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
                
//                //Firebase login
//                FIRAuth.auth()?.signIn(with: credential) { (user, error) in
//                    if error != nil {
//                        
//                        
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
//                            
//                            
//                            //after login, gonna go to map setting
//                            let SelectAddressViewController: SelectAddressViewController = self.storyboard?.instantiateViewController(withIdentifier: "SelectAddressView") as! SelectAddressViewController
//                            
//                            let navi = UINavigationController(rootViewController: SelectAddressViewController)
//                            // setting animation
//                            navi.modalTransitionStyle = .crossDissolve
//                            self.present(navi, animated: true, completion: nil)
//                            
//                            
//                            
//                            
//                            
//                        }else{
//                            print("no exist!")
//                        }
//                        
//                    }
//                }
                
                
                
                
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
                self.firstname_input.text = self.userProfile["first_name"] as! String
                self.lastname_input.text  = self.userProfile["last_name"] as! String
                self.email_input.text     = self.userProfile["email"] as! String

                
            }
        })
        
    }

    
    @IBAction func click_create(_ sender: UIButton) {
        print(self.firstname_input)
        
        let email: String! = self.email_input.text
        let username: String! = self.firstname_input.text
        let password: String! = self.password_input.text
        
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            
            if let errCode = FIRAuthErrorCode(rawValue: error!._code) {
                print("🌟",errCode)
                switch errCode {
                case .errorCodeWrongPassword:
                    self.alert_win(error:LoginErrorCode.WRONG_PASSWORD)
                    break;
                case .errorCodeInvalidEmail:
                    self.alert_win(error:LoginErrorCode.INVALID_EMAIL)
                    break;
                case .errorCodeUserNotFound:
                    self.alert_win(error:LoginErrorCode.USER_NOT_FOUND)
                    break;
                case .errorCodeEmailAlreadyInUse:
                    self.alert_win(error:LoginErrorCode.EMAIL_ALREADY_IN_USE)
                    break;
                case .errorCodeWeakPassword:
                    self.alert_win(error:LoginErrorCode.WEAK_PASSWORD)
                    break;
                default:
                    self.alert_win(error:LoginErrorCode.PROBLEM_CONNECTING)
                    break;
                    
                }
                
                return
                
            }else{
                //If there is no error...
                self.ref = FIRDatabase.database().reference()
                self.ref.child("users").child(user!.uid).setValue(["email": email])
                self.ref.child("users").child(user!.uid).setValue(["username": username])
                self.ref.child("users").child(user!.uid).setValue(["password": password])
                
                
            }
            
            
        }
        
    }
    
    
    
    func alert_win(error:String){
        
        let alert: UIAlertController = UIAlertController(title: "Something Wrong", message: error, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            // something
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)

    }
    
    
    
    
}



extension UIColor{
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha:1)
    }
}
