//
//  PaymentViewController.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/05/06.
//  Copyright © 2017年 shinji. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Payment"
        view.backgroundColor = UIColor(r:255,g:255,b:255)
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.barButtonItemClicked)), animated: true)
        
        
    }
    
    func barButtonItemClicked(){
        print("😏")
    }


}
