//
//  IngredientDetailViewController.swift
//  MyJuice_HS
//
//  Created by HannahPark on 2017-04-12.
//  Copyright © 2017 student. All rights reserved.
//

import UIKit

class IngredientDetailViewController: UIViewController {
    
    var images = [#imageLiteral(resourceName: "AppleImage"), #imageLiteral(resourceName: "banana"), #imageLiteral(resourceName: "Pineapple"), #imageLiteral(resourceName: "watermelon"), #imageLiteral(resourceName: "orange"), #imageLiteral(resourceName: "strawberry"), #imageLiteral(resourceName: "celery"), #imageLiteral(resourceName: "tomato"), #imageLiteral(resourceName: "grapes"), #imageLiteral(resourceName: "avocado"), #imageLiteral(resourceName: "carrot")]
    var prices = [2.50, 2.50, 3.00, 3.00, 3.00, 3.10, 3.10, 2.75, 2.75, 2.50, 2.00]
    
    @IBOutlet weak var label: UILabel!
    var selectedItems = [Int]()
    var image: String?
    var ingredient: UIImage?
    var price: Double? = 0
    @IBOutlet weak var ingredient1: UIImageView!
    @IBOutlet weak var ingredient2: UIImageView!
    @IBOutlet weak var ingredient3: UIImageView!
    
    //    var numberArray = NSMutableArray()
    //    var selectedArray=NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ingredient1.image = self.images[selectedItems[0]]
        self.ingredient2.image = self.images[selectedItems[1]]
        self.ingredient3.image = self.images[selectedItems[2]]
        
        self.addItemPrice(index: selectedItems[0])
        self.addItemPrice(index: selectedItems[1])
        self.addItemPrice(index: selectedItems[2])
        
    }
    
    
    func addItemPrice(index: Int) {
        self.price = self.price! + self.prices[index]
        self.label.text = "$ \(self.price!)"
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
    }
    
}

