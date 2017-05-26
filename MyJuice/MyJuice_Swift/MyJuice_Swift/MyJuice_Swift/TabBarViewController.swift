//
//  TabBarViewController.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/04/30.
//  Copyright © 2017年 shinji. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        badgeUpdate()
        UserDefaults.standard.addObserver(self,forKeyPath: "myCart", options: NSKeyValueObservingOptions.new, context: nil)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.badgeUpdate()
    }
    
    func badgeUpdate(){
        if let cart2 = self.userDefaults.array(forKey: "myCart"){
            if(cart2.count > 0){
                self.viewControllers?[1].tabBarItem.badgeValue = String(cart2.count)
            }
        }else{
            self.viewControllers?[1].tabBarItem.badgeValue = nil
        }
        print("きた？")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


    
    override func viewWillAppear(_ animated: Bool) {
//        print("🐔")
//        
//        if let controller = self.presentingViewController as? SignInViewController{
//            print("😏2")
//            print(controller.item)
//        }
//        if let controller2 = self.presentingViewController as? SignInUserViewController{
//            print("😷2")
//            //            print(controller2.item)
//        }
//        if (self.presentingViewController as? RegisterViewController) != nil{
//            print("☎️2")
//            //            print(controller2.item)
//        }
        
        
        
        
        
    }


}
