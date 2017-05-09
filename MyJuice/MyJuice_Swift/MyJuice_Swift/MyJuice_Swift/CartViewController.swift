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
    
//    struct Cart {
//        let productID: NSInteger
//        let email: String = "email"
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        userDefaults.register(defaults: ["DataStore": "default"])
//        view.backgroundColor = UIColor(r:255,g:255,b:255)
        
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
        
        let collectionView                          = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.frame                        = CGRect(x: 0, y: self.view.frame.height - (60+tabHeight!), width: self.view.frame.width, height: 60)
        collectionView.dataSource                   = self
        collectionView.delegate                     = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellcol")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor              = UIColor.clear
        self.view.addSubview(collectionView)
        
        
        let loadedCart = UserDefaults.standard.array(forKey: "myCart") as? [[String: Any]]
        
//        let cartDictionary = loadedCart?[0] as! NSDictionary
//        let toCartArray = cartDictionary["ingr"] as! NSArray
//        var items: [String] = toCartArray as [AnyObject] as! [String]
//        
        cartJsonVar = JSON(loadedCart)
        self.tableView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellcol", for: indexPath)
        cell.backgroundColor = UIColor.orange
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        print("User tapped on item \(indexPath.row)")
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "My Cart"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
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

            
            var textField:UILabel = UILabel()
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

extension UIColor{
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha:1)
    }
}

