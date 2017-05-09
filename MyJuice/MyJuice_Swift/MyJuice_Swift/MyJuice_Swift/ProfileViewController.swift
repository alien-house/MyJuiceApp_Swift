//
//  ProfileViewController.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/05/01.
//  Copyright © 2017年 shinji. All rights reserved.
//

import UIKit

//@objc(ProfileViewController)

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellId = "cellId"
    var tableView: UITableView  =   UITableView()
    let navTitle = ["test01","test02","test03"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Profile"
        view.backgroundColor = UIColor(r:255,g:255,b:255)
        
//        let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        
        tableView.frame         =   CGRect(x: 0, y: 0, width: self.view.frame.width, height: 260)
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        //button.addTarget(self, action: #selector(self.onClick(_:)), for: .touchUpInside)
//        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.goBefore))]
        
    }
    
    
    func goBefore() {
                self.navigationController?.popViewController(animated: true)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func saveData(str: String){
        
        // Keyを指定して保存
//        userDefaults.set(str, forKey: "DataStore")
//        userDefaults.synchronize()
        
    }
    func readData() -> String {
        // Keyを指定して読み込み
//        let str: String = userDefaults.object(forKey: "DataStore") as! String
        
//        return str
        return "s"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style:.subtitle, reuseIdentifier:cellId)
        cell.textLabel?.text = navTitle[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
}
