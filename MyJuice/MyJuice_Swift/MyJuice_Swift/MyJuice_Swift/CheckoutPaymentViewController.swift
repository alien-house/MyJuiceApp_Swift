//
//  CheckoutPaymentViewController.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/05/18.
//  Copyright © 2017年 shinji. All rights reserved.
//

import UIKit

protocol CheckoutPayDelegate {
    func payValueSet(dateString:String)
}

class CheckoutPaymentViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var delegate:CheckoutPayDelegate?
    private var myUIPicker: UIPickerView!
    private let myValues: NSArray = ["pick up","delivered"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r:255,g:255,b:255)
        myUIPicker = UIPickerView()
        myUIPicker.frame = CGRect(x: 0, y: self.view.frame.height - 300, width: self.view.frame.width, height: 300)
        myUIPicker.delegate = self
        myUIPicker.dataSource = self
        self.view.addSubview(myUIPicker)
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myValues[row] as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.delegate?.payValueSet(dateString: myValues[row] as! String)
        navigationController?.popViewController(animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
}
