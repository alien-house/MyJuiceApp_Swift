//
//  CheckoutViewController.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/04/19.
//  Copyright © 2017年 shinji. All rights reserved.
//

import UIKit


//http://stackoverflow.com/questions/26158768/how-to-get-textlabel-of-selected-row-in-swift

class CheckoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var checkoutTable: UITableView!
    
    var objects:NSMutableArray! = NSMutableArray()
    
    override func viewDidLoad() {
        
        //prepear the table
        self.checkoutTable.delegate = self
        self.checkoutTable.dataSource = self
        
        self.objects.add("Payment")
        self.objects.add("Credit Card")
        self.objects.add("ETA")
        
        self.checkoutTable.reloadData()
        
    }
    
    //Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        if let cell:CheckoutTableCell = self.checkoutTable.dequeueReusableCell(withIdentifier: "checkoutTableCell") as? CheckoutTableCell{
        
            cell.checoutLabel.text = self.objects.object(at: indexPath.row) as? String
            cell.checoutStateLabel.text = "sssss"
            
            return cell
            
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
//        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
        
        
        
    }
    
}
