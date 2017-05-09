//
//  Cart.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/05/06.
//  Copyright © 2017年 shinji. All rights reserved.
//

import UIKit

class Cart:NSObject{
    var productID:NSInteger = 0
    var quantity:NSInteger  = 0
    var ingredient:NSDictionary = [:]
    var bottle:NSDictionary = [:]
    /*
     
    */
     init(productID:NSInteger, quantity:NSInteger, ingredient:NSDictionary, bottle:NSDictionary) {
        self.productID = productID
        self.quantity = quantity
        self.ingredient = ingredient
        self.bottle = bottle
//        self.ingredient = [ 1:"Apple",3:"Pineapple",5:"Pomegranates" ]
//        self.bottle = [23:"skull family"]
    }
    
    
//    required convenience init(coder aDecoder: NSCoder) {
//        let productID = aDecoder.decodeInteger(forKey: "productID")
//        let quantity = aDecoder.decodeInteger(forKey: "quantity")
//        let ingredient = aDecoder.decodeInteger(forKey: "ingredient") as! NSDictionary
//        let bottle = aDecoder.decodeInteger(forKey: "bottle") as! NSDictionary
////        let name = aDecoder.decodeObject(forKey: "name") as! String
////        let shortname = aDecoder.decodeObject(forKey: "shortname") as! String
////        self.init(id: id, name: name, shortname: shortname)
//        self.init(productID:productID, quantity:quantity, ingredient:ingredient, bottle:bottle)
//    }
}

