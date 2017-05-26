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
        view.backgroundColor = UIColor(r:255,g:255,b:255)
        
    }
    
    func clickButton(){
        
        self.dismiss(animated: true, completion: nil)
                
    }
}
