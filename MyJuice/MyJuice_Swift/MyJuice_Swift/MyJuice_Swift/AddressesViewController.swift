//
//  AddressesViewController.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/05/06.
//  Copyright © 2017年 shinji. All rights reserved.
//

import UIKit
import Firebase

class AddressesViewController: UIViewController {
    var txtLabel: UILabel!
    var ref: FIRDatabaseReference!
    let changeButton:UIButton = {
        let btn = UIButton(type:.custom)
        let fbcolor:UIColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        btn.backgroundColor = fbcolor
        btn.layer.cornerRadius = 4.0
        btn.tag = 0
        btn.setTitle("change", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.frame = CGRect(x:20, y:460, width:300, height:50)
        btn.addTarget(self, action: #selector(changeButtonClicked), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Addresses"
        view.backgroundColor = UIColor(r:255,g:255,b:255)
        
        txtLabel = UILabel(frame: CGRect(x: 10, y: 90, width: 230, height: 30))
        
        self.view.addSubview(self.changeButton)
        self.view.addSubview(txtLabel)
        
        if FIRAuth.auth()?.currentUser != nil {
            
            ref = FIRDatabase.database().reference()
            
            let userID = FIRAuth.auth()?.currentUser?.uid
            ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                self.txtLabel.text = value?["address"] as? String
            }) { (error) in
                print(error.localizedDescription)
            }
            
        }else{
            print("Need login")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func changeButtonClicked(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "SelectAddressView")
        
        self.navigationController?.pushViewController(nextView, animated: true)
        
    }

}
