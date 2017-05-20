//
//  CartViewController.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/05/06.
//  Copyright © 2017年 shinji. All rights reserved.
//

import UIKit
import SwiftyJSON



class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    let cellId = "cellId"
    var tableView: UITableView  =   UITableView()
    let userDefaults = UserDefaults.standard
    var cartJsonVar:JSON = ""
    var totalPrice:Double = 0.0
    
//    struct Cart {
//        let productID: NSInteger
//        let email: String = "email"
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        userDefaults.register(defaults: ["DataStore": "default"])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.navigationItem.title = "My Cart"
        // Table View
        let statusBarHeight: CGFloat     = UIApplication.shared.statusBarFrame.height
        let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.height
        tableView.frame                  = CGRect(x: 0, y: statusBarHeight+navigationBarHeight, width: self.view.frame.width, height: 360)
        tableView.delegate               = self
        tableView.dataSource             = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        // Collection View
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 60)
        
        if (userDefaults.object(forKey: "myCart") != nil) {
            
            let loadedCart = UserDefaults.standard.array(forKey: "myCart") as? [[String: Any]]
            cartJsonVar = JSON(loadedCart!)
            self.tableView.reloadData()
            
            totalPrice = 0.0
            for node in self.cartJsonVar {
                totalPrice += node.1["price"][0].doubleValue;
            }
            
            if(!self.cartJsonVar.isEmpty){
                let tabHeight = self.tabBarController?.tabBar.frame.size.height
                let collectionView                          = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
                collectionView.frame                        = CGRect(x: 0, y: self.view.frame.height - (60+tabHeight!), width: self.view.frame.width, height: 60)
                collectionView.dataSource                   = self
                collectionView.delegate                     = self
                collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellcol")
                collectionView.showsVerticalScrollIndicator = false
                collectionView.backgroundColor              = UIColor.clear
                self.view.addSubview(collectionView)
            }
        }else{
            
            print("😓")
            print(self.cartJsonVar)
            self.cartJsonVar = ""
            self.totalPrice = 0.0
            self.tableView.reloadData()
//            self.tableView.reloadData()
        }
        
    }
    
    // Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(!self.cartJsonVar.isEmpty){
            return 1
        }else{
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellcol", for: indexPath)
        cell.backgroundColor = UIColor(r:255,g:168,b:0)
        let textField:UILabel = UILabel()
        textField.text = "Checkout"
        textField.textColor = UIColor.white
        textField.font = UIFont.systemFont(ofSize: 24)
        textField.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        textField.frame         =   CGRect(x: 0, y: 10, width: self.view.frame.width, height: 40)
        textField.textAlignment = NSTextAlignment.center
        cell.contentView.addSubview(textField)
        
        let textPriceField:UILabel = UILabel()
        textPriceField.text = "$ " + (NSString(format: "%.2f", self.totalPrice) as String)
        textPriceField.textColor = UIColor.white
        textPriceField.frame         =   CGRect(x: self.view.frame.width - 90, y: 15, width: 80, height: 30)
        textPriceField.textAlignment = NSTextAlignment.right
        //            let numStr:String = NSString(format: "%.2f", node["price"][0].doubleValue) as String
        cell.contentView.addSubview(textPriceField)
        
        return cell
    }
    
    // User tap checkout button
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        let CheckoutViewController: CheckoutViewController = self.storyboard?.instantiateViewController(withIdentifier: "Checkout") as! CheckoutViewController
        
//        StoreDetailViewController.atai = marker.userData as AnyObject
//        present(CheckoutViewController, animated: true, completion: nil)
        
        
        let navi = UINavigationController(rootViewController: CheckoutViewController)
//        navi.modalTransitionStyle = .crossDissolve
        present(navi, animated: true, completion: nil)
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(!self.cartJsonVar.isEmpty){
            return cartJsonVar.count
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style:.subtitle, reuseIdentifier:cellId)
        
        if(!self.cartJsonVar.isEmpty){
            var titleString:String = ""
            for i in 0..<self.cartJsonVar[indexPath.row]["ingr"].count {
                if(!(i == 0)){ titleString += " + " }
                titleString = titleString + (self.cartJsonVar[indexPath.row]["ingr"][i].string)!
                cell.textLabel?.text = titleString
            }
            
            let textField:UILabel = UILabel()
//            var test = self.cartJsonVar[indexPath.row]["price"][0].doubleValue
            let numStr:String = NSString(format: "%.2f", self.cartJsonVar[indexPath.row]["price"][0].doubleValue) as String
            textField.text = "$ " + numStr
            textField.frame         =   CGRect(x: self.view.frame.width - 90, y: 10, width: 80, height: 30)
            textField.textAlignment = NSTextAlignment.right
            cell.contentView.addSubview(textField)
            
        }
        return cell
        
    }


}

