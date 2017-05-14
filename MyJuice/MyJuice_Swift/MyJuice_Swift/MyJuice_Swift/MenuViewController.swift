//
//  MenuViewController.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/05/07.
//  Copyright © 2017年 shinji. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var cart: [[String: Any]] = []
        cart.append(["ingr": ["Apple","Pineapple"], "bottle": ["skull family"], "price": [12.05], "qty": [1]])
        cart.append(["ingr": ["Banana","Mango","Strawberry"], "bottle": ["don't forget it!"], "price": [16], "qty": [5]])
        
        
        userDefaults.set(cart, forKey: "myCart")
        userDefaults.synchronize()
        
        
        self.tabBarController?.viewControllers?[1].tabBarItem.badgeValue = "2"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.navigationItem.title = "Menu"
        
    }
    

}
