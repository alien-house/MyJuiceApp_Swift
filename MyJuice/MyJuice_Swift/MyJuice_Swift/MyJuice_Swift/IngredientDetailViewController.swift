//
//  IngredientDetailViewController.swift
//  MyJuice_HS
//
//  Created by HannahPark on 2017-04-12.
//  Copyright © 2017 student. All rights reserved.
//

import UIKit

class IngredientDetailViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    var selectedItems = [Int]()
    var image: String?
    var ingredient: UIImage?
    var price: Double?
    @IBOutlet weak var ingredient1: UIImageView!
    @IBOutlet weak var ingredient2: UIImageView!
    @IBOutlet weak var ingredient3: UIImageView!
    @IBOutlet weak var IngredientPrice: UILabel!
    
    //    var numberArray = NSMutableArray()
    //    var selectedArray=NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.addItemPrice(index: selectedItems[0])
//        self.addItemPrice(index: selectedItems[1])
//        self.addItemPrice(index: selectedItems[2])
//        
//        //        print("prepare done")
//        
//        print(self.image!)
        //
        //        self.ingredient1.image = UIImage(named: self.image! )
        
    }
    
    // MARK: - Navigation
    
    func addItemPrice(index: Int) {
        switch index {
        case 0:
            self.price = self.price! + 1.00
            break
        case 1:
            break
        case 2:
            break
        case 3:
            break
        case 4:
            break
        case 5:
            break
        case 6:
            break
        case 7:
            break
        case 8:
            break
        case 9:
            break
        case 10:
            break
        default:
            break
        }
    }
    
    
}

