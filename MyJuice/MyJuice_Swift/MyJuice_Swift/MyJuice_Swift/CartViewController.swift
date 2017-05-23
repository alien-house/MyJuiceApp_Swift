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
    var collectionView:UICollectionView!
    let userDefaults = UserDefaults.standard
    var cartJsonVar:JSON = ""
    var totalPrice:Double = 0.0
    
//    struct Cart {
//        let productID: NSInteger
//        let email: String = "email"
//    }
    
    //for test
    let testButton:UIButton = {
        let btn = UIButton(type:.custom)
        let fbcolor:UIColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        btn.backgroundColor = fbcolor
        btn.layer.cornerRadius = 4.0
        btn.tag = 0
        btn.setTitle("adddd", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.frame = CGRect(x:20, y:560, width:300, height:50)
        btn.addTarget(self, action: #selector(testButtonClicked), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //for test =======================
        self.view.addSubview(self.testButton)
        //=======================
        UserDefaults.standard.addObserver(self,forKeyPath: "myCart", options: NSKeyValueObservingOptions.new, context: nil)
        userDefaults.register(defaults: ["DataStore": "default"])
        
    }
    
    //for test =======================
    func testButtonClicked(){
        print("㊗️")
        var cart: [[String: Any]] = []
        cart.append(["ingr": ["Apple","Pineapple"], "bottle": ["skull family"], "price": [12.05], "qty": [1]])
        cart.append(["ingr": ["Banana","Mango","Strawberry"], "bottle": ["don't forget it!"], "price": [16], "qty": [5]])
        userDefaults.set(cart, forKey: "myCart")
    
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("きた？")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.navigationItem.title = "My Cart"
        print("🎿My Cart")
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
        let tabHeight = self.tabBarController?.tabBar.frame.size.height
        collectionView = UICollectionView(frame: CGRect(x: 0, y: self.view.frame.height - (60+tabHeight!), width: self.view.frame.width, height: 60), collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.dataSource                   = self
        collectionView.delegate                     = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellcol")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor              = UIColor.clear
        
        
        if (userDefaults.object(forKey: "myCart") != nil) {
            
            let loadedCart = UserDefaults.standard.array(forKey: "myCart") as? [[String: Any]]
            cartJsonVar = JSON(loadedCart!)
            self.tableView.reloadData()
            
            totalPrice = 0.0
            if((loadedCart?.count)! > 0 ){
                for node in self.cartJsonVar {
                    totalPrice += node.1["price"][0].doubleValue;
                }
            }
            
            if(!self.cartJsonVar.isEmpty){
                self.view.addSubview(collectionView)
            }
        }else{
            
            print("😓")
            print(self.cartJsonVar)
            self.cartJsonVar = ""
            self.totalPrice = 0.0
            print(!self.cartJsonVar.isEmpty)
            self.tableView.reloadData()
            self.collectionView.reloadData()
        }
        
    }
    
    // Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(!self.cartJsonVar.isEmpty){
            return 1
        }else{
            print("☁️")
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

