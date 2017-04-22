//
//  CheckoutViewController.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/04/19.
//  Copyright © 2017年 shinji. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var checkoutTable: UITableView!
    
    var objects:NSMutableArray! = NSMutableArray()
    
    override func viewDidLoad() {
        
        //prepear the table
        self.checkoutTable.delegate = self
        self.checkoutTable.dataSource = self
        
        self.objects.add("test1")
        self.objects.add("test2")
        self.objects.add("test3")
        
        self.checkoutTable.reloadData()
        
    }
    
    //Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
//        if let cell:CheckoutTableCell = self.checkoutTable.dequeueReusableCell(withIdentifier: "checkoutTableCell") as? CheckoutTableCell{
//        
//            cell.checoutLabel.text = self.objects.objectAtIndex(indexPath.row) as? String
//        
//            return cell
//            
//        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    
}
