//
//  CheckoutViewController.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/04/19.
//  Copyright © 2017年 shinji. All rights reserved.
//

import UIKit
import Firebase

//http://stackoverflow.com/questions/26158768/how-to-get-textlabel-of-selected-row-in-swift

class CheckoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,CheckoutETADelegate,CheckoutPayDelegate,CheckoutCCDelegate {
    
    let userDefaults = UserDefaults.standard
    @IBOutlet weak var checkoutTable: UITableView!
    
    var objects:NSMutableArray! = NSMutableArray()
    var objectsUserSelected:[String:String] = [:]
    var ref: FIRDatabaseReference!
    
    func payValueSet(dateString:String) {
        self.objectsUserSelected["payment"] = dateString
        self.checkoutTable.reloadData()
    }
    func ccValueSet(dateString:String) {
        self.objectsUserSelected["craditcard"] = dateString
        self.checkoutTable.reloadData()
    }
    func etaValueSet(dateString:String) {
        self.objectsUserSelected["eta"] = dateString
        self.checkoutTable.reloadData()
    }
    
    override func viewDidLoad() {
        
        //prepear the table
        self.checkoutTable.delegate = self
        self.checkoutTable.dataSource = self
        
        self.objects.add("Address")
        self.objects.add("Payment")
        self.objects.add("Credit Card")
        self.objects.add("ETA")
        
        self.checkoutTable.reloadData()
        
        //for Collection View
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 60)
        let collectionView                          = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.frame                        = CGRect(x: 0, y: self.view.frame.height - (60), width: self.view.frame.width, height: 60)
        collectionView.dataSource                   = self
        collectionView.delegate                     = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellcol")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor              = UIColor.clear
        self.view.addSubview(collectionView)
        
        
        //getting information
        if FIRAuth.auth()?.currentUser != nil {
            
            ref = FIRDatabase.database().reference()
            let userID = FIRAuth.auth()?.currentUser?.uid
            ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                let address = value?["address"] as? String ?? ""
                self.objectsUserSelected["address"] = address
                self.checkoutTable.reloadData()
                
            }) { (error) in
                print(error.localizedDescription)
            }
            
        }else{
            print("Need login")
        }
        
        
        
    }
    
    
    // Collection View ===============================================
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
//        if(!self.cartJsonVar.isEmpty){
//            return 1
//        }else{
//            return 0
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellcol", for: indexPath)
        cell.backgroundColor = UIColor(r:255,g:168,b:0)
        let textField:UILabel = UILabel()
        textField.text = "Make Order"
        textField.textColor = UIColor.white
        textField.font = UIFont.systemFont(ofSize: 24)
        textField.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        textField.frame         =   CGRect(x: 0, y: 10, width: self.view.frame.width, height: 40)
        textField.textAlignment = NSTextAlignment.center
        cell.contentView.addSubview(textField)
//
//        let textPriceField:UILabel = UILabel()
//        textPriceField.text = "$ " + (NSString(format: "%.2f", self.totalPrice) as String)
//        textPriceField.textColor = UIColor.white
//        textPriceField.frame         =   CGRect(x: self.view.frame.width - 90, y: 15, width: 80, height: 30)
//        textPriceField.textAlignment = NSTextAlignment.right
        //            let numStr:String = NSString(format: "%.2f", node["price"][0].doubleValue) as String
//        cell.contentView.addSubview(textPriceField)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
//        if(self.objectsUserSelected.count == 4){
          if(self.objectsUserSelected.count == 1){
            
            
            let alert: UIAlertController = UIAlertController(title: "", message: "Are you really gonna buy?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Buy", style: .default) { action in
                
                let cvc = CompleteViewController()
                cvc.modalTransitionStyle = .crossDissolve
                // delete
                self.userDefaults.removeObject(forKey: "myCart")
                self.present(cvc, animated: true, completion: nil)
                
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default) { action in
                print("Cancel")
            }
            
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            
            
            
            // if complete, cart is gonna deleted
            
            
            //        self.dismiss(animated: true, completion: nil)
            
            //        let TabBarViewController: TabBarViewController = self.storyboard?.instantiateViewController(withIdentifier: "tabBar") as! TabBarViewController
            //
            //        let navi = UINavigationController(rootViewController: TabBarViewController)
            //        navi.modalTransitionStyle = .crossDissolve
            //        present(navi, animated: true, completion: nil)
            
        }else{
            
            let alert: UIAlertController = UIAlertController(title: "", message: "Please input these or chooose", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { action in
                print("Action OK!!")
                
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    // Table View ===============================================
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        if let cell:CheckoutTableCell = self.checkoutTable.dequeueReusableCell(withIdentifier: "checkoutTableCell") as? CheckoutTableCell{
            
            cell.checoutLabel.text = self.objects.object(at: indexPath.row) as? String
            
            if(indexPath.row == 0){
                //Address
                cell.checoutStateLabel.text = self.objectsUserSelected["address"]
            }else if(indexPath.row == 1){
                //Payment [directly or delivered]
                cell.checoutStateLabel.text = self.objectsUserSelected["payment"]
                
            }else if(indexPath.row == 2){
                //cradit card [input number or directly]
                cell.checoutStateLabel.text = self.objectsUserSelected["craditcard"]
                
            }else if(indexPath.row == 3){
                //ETA [can choose time ]
                cell.checoutStateLabel.text = self.objectsUserSelected["eta"]
                
            }else{
            }
            
            
            return cell
            
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("🐶")
        if(indexPath.row == 0){
            
//            let storyboard: UIStoryboard = self.storyboard!
//            let nextView = storyboard.instantiateViewController(withIdentifier: "SelectAddressNaviView")
//            present(nextView, animated: true, completion: nil)
            
            let nextView = storyboard?.instantiateViewController(withIdentifier: "SelectAddressView")
            self.navigationController?.pushViewController(nextView!, animated: true)
            
        }else if(indexPath.row == 1){
            let nextView = CheckoutPaymentViewController()
            nextView.delegate = self
            self.navigationController?.pushViewController(nextView, animated: true)
            
        }else if(indexPath.row == 2){
            let nextView = CheckoutCreditcardViewController()
            nextView.delegate = self
            self.navigationController?.pushViewController(nextView, animated: true)
            
        }else if(indexPath.row == 3){
            let nextView = CheckoutETAViewController()
            nextView.delegate = self
            self.navigationController?.pushViewController(nextView, animated: true)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
//        self.navigationController?.popViewController(animated: true)
        
    }
    
}
