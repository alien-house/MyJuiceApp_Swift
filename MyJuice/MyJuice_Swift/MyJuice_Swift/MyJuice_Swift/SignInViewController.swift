//
//  SignInViewController.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/04/03.
//  Copyright © 2017年 shinji. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController  {
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
//        loginButton.center = view.center
//        
//        view.addSubview(loginButton)
        // Do any additional setup after loading the view, typically from a nib.
        
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
    
//    
//    //ログインボタンが押された時の処理。Facebookの認証とその結果を取得する
//    func loginButton(loginButton: FBSDKLoginButton!,didCompleteWithResult
//        result: FBSDKLoginManagerLoginResult!, error: NSError!) {
//        println("User Logged In")
//        
//        if ((error) != nil)
//        {
//            //エラー処理
//        } else if result.isCancelled {
//            //キャンセルされた時
//        } else {
//            //必要な情報が取れていることを確認(今回はemail必須)
//            if result.grantedPermissions.contains("email")
//            {
//                // 次の画面に遷移（後で）
//            }
//        }
//    }
//    
//    //ログアウトボタンが押された時の処理
//    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
//        println("User Logged Out")
//    }
//    
    
    
    
    
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
    
    
    
    
}

