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
    var dateString:String = ""
    
    let ccButton:UIButton = {
        let btn = UIButton(type:.custom)
        let fbcolor:UIColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        btn.backgroundColor = fbcolor
        btn.layer.cornerRadius = 4.0
        btn.tag = 0
        btn.setTitle("Register this time", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.frame = CGRect(x:40, y:160, width:300, height:40)
        btn.addTarget(self, action: #selector(ccButtonClicked), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r:255,g:255,b:255)
        let myUIPicker: UIDatePicker = UIDatePicker()
        myUIPicker.frame = CGRect(x: 0, y: self.view.frame.height - 300, width: self.view.frame.width, height: 300)
        myUIPicker.datePickerMode = UIDatePickerMode.time
        self.view.addSubview(myUIPicker)
        self.view.addSubview(self.ccButton)
        
        myUIPicker.addTarget(self, action: #selector(dataPickerAction), for: UIControlEvents.valueChanged)
        
    }
    
    func dataPickerAction(sender:UIDatePicker){
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateStyle = .medium
        self.dateFormatter.timeStyle = .none
        self.dateFormatter.timeZone = NSTimeZone.local
        self.dateFormatter.dateFormat = "YYYY-MM-dd hh:mm a"
        self.dateString = dateFormatter.string(from: sender.date as Date)
        
        //        dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .medium
//        dateFormatter.timeStyle = .none
//        dateFormatter.timeZone = NSTimeZone.local
//        dateFormatter.dateFormat = "YYYY-MM-dd hh:mm a"
//        let dateString = dateFormatter.string(from: sender.date as Date)
//        print(sender.date)
//        print(dateString)
//        self.delegate?.etaValueSet(dateString: dateString)
//        
//        navigationController?.popViewController(animated: true)
        
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
    
    func ccButtonClicked() {
        popAlert()
    }
    
    func popAlert(){
        let alert: UIAlertController = UIAlertController(title: "", message: "Is it Okay?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            
            self.delegate?.etaValueSet(dateString: self.dateString)
            
            //        self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { action in
            print("Cancel")
        }
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
