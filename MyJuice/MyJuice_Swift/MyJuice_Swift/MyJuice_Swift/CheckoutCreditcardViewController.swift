//
//  CheckoutCreditcardViewController.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/05/18.
//  Copyright © 2017年 shinji. All rights reserved.
//

import UIKit
import Firebase


protocol CheckoutCCDelegate {
    func ccValueSet(dateString:String)
}

class CheckoutCreditcardViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    var ref: FIRDatabaseReference!
    var delegate:CheckoutCCDelegate?
    private var myUIPicker: UIPickerView!
    private let myValues: NSArray = ["cash","input number"]
//    private let ccNumber = UITextField(frame: CGRect(x:20, y:100, width:300, height:40))
//    private let ccBtn = UIButton(frame: CGRect(x:20, y:180, width:300, height:50))
    
    
    let ccButton:UIButton = {
        let btn = UIButton(type:.custom)
        let fbcolor:UIColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        btn.backgroundColor = fbcolor
        btn.layer.cornerRadius = 4.0
        btn.tag = 0
        btn.setTitle("Register this Card", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.frame = CGRect(x:20, y:160, width:300, height:40)
        btn.addTarget(self, action: #selector(ccButtonClicked), for: .touchUpInside)
        return btn
    }()
    
    let ccNumber:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter text here"
        txt.tag = 1
        txt.font = UIFont.systemFont(ofSize: 15)
        txt.borderStyle = UITextBorderStyle.roundedRect
        txt.autocorrectionType = UITextAutocorrectionType.no
        txt.delegate = self as? UITextFieldDelegate
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.frame = CGRect(x:20, y:100, width:300, height:40)
        return txt
    }()
    
    let ccInputView:UIView = {
        let view = UIView()
//        view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        view.tag = 100
//        view.isUserInteractionEnabled = true
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r:255,g:255,b:255)
        myUIPicker = UIPickerView()
        myUIPicker.frame = CGRect(x: 0, y: self.view.frame.height - 300, width: self.view.frame.width, height: 300)
        myUIPicker.delegate = self
        myUIPicker.dataSource = self
        self.view.addSubview(myUIPicker)
        
        
        ccNumber.delegate = self
        ccNumber.returnKeyType = .done
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textFieldDidChange),
            name: NSNotification.Name.UITextFieldTextDidChange,
            object: ccNumber)
        ref = FIRDatabase.database().reference()
        
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
        
        
        if(row == 1){
            self.view.addSubview(self.ccInputView)
            self.ccInputView.addSubview(self.ccNumber)
            self.ccInputView.addSubview(self.ccButton)
            
            //        let alert: UIAlertController = UIAlertController(title: "", message: "Is it Okay?", preferredStyle: .alert)
            //        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            //
            //
            //        }
            //        alert.addAction(okAction)
            //        self.present(alert, animated: true, completion: nil)
            //
        }else{
            self.delegate?.ccValueSet(dateString: myValues[row] as! String)
            navigationController?.popViewController(animated: true)
            
            if let viewWithTag = self.view.viewWithTag(self.ccInputView.tag) {
                viewWithTag.removeFromSuperview()
            }
            else {
                print("tag not found")
            }
            
        }
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func popAlert(text: String){
        let alert: UIAlertController = UIAlertController(title: "", message: "Is it Okay to register?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            FIRAuth.auth()?.addStateDidChangeListener { auth, user in
                if let user = user {
                    self.ref.child("users").child(user.uid).updateChildValues(["creditcard": text])
                    self.delegate?.ccValueSet(dateString: self.myValues[1] as! String)
                    self.navigationController?.popViewController(animated: true)
                } else {
                    print("😄","nothing")
                    
                    let alert: UIAlertController = UIAlertController(title: "You need to login", message: "Please register your account or sign in", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { action in
                    }
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                    
                    
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { action in
            print("Cancel")
        }
        alert.addAction(cancelAction)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func ccButtonClicked() {
        popAlert(text: self.ccNumber.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ccNumber.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldDidChange(notification: NSNotification) {
        let textFieldString = notification.object as! UITextField
        if let text = textFieldString.text {
            if text.characters.count > 16 {
                ccNumber.text = text.substring(to: text.index(text.startIndex, offsetBy: 15))
            }
        }
    }


}
