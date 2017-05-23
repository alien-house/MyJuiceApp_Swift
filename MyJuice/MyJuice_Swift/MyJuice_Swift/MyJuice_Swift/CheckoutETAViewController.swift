//
//  CheckoutETAViewController.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/05/18.
//  Copyright © 2017年 shinji. All rights reserved.
//

import UIKit

protocol CheckoutETADelegate {
    func etaValueSet(dateString:String)
}

class CheckoutETAViewController: UIViewController {
    
    var dateFormatter : DateFormatter!
    var delegate:CheckoutETADelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r:255,g:255,b:255)
        let myUIPicker: UIDatePicker = UIDatePicker()
        myUIPicker.frame = CGRect(x: 0, y: self.view.frame.height - 300, width: self.view.frame.width, height: 300)
        myUIPicker.datePickerMode = UIDatePickerMode.time
        self.view.addSubview(myUIPicker)
        
        myUIPicker.addTarget(self, action: #selector(dataPickerAction), for: UIControlEvents.valueChanged)
        
    }
    
    func dataPickerAction(sender:UIDatePicker){
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = "YYYY-MM-dd hh:mm a"
        let dateString = dateFormatter.string(from: sender.date as Date)
        print(sender.date)
        print(dateString)
        self.delegate?.etaValueSet(dateString: dateString)
        
        //        self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
        
//        
//        let alert: UIAlertController = UIAlertController(title: "", message: "Is it Okay?", preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .default) { action in
//            
//            
//            
//        }
//        alert.addAction(okAction)
//        self.present(alert, animated: true, completion: nil)
//        
//        
        
    }
    
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("row: \(row)")
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
