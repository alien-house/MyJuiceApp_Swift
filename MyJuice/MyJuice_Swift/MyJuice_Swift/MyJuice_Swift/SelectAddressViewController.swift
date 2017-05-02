//
//  SelectAddressViewController.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/04/16.
//  Copyright © 2017年 shinji. All rights reserved.
//

import UIKit


class SelectAddressViewController: UIViewController{
    
    struct User {
        let name: String = "name"
        let email: String = "email"
    }
    var user = User()
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let str: String = userDefaults.object(forKey: user.name) as! String
        print("🤧")
        print(str)
    }

}
