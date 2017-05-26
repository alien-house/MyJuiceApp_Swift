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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
