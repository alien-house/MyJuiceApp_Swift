//
//  inputAddressViewController.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/04/16.
//  Copyright © 2017年 shinji. All rights reserved.
//
import UIKit
import GoogleMaps
import GooglePlaces
import Firebase
import FirebaseAuth

class inputAddressViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self as GMSAutocompleteResultsViewControllerDelegate
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        let subView = UIView(frame: CGRect(x: 0, y: 65.0, width: self.view.frame.width, height: 85.0))
        
        subView.addSubview((searchController?.searchBar)!)
        view.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
        
    }
    
    
    
}



// Handle the user's selection.
extension inputAddressViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        searchController?.searchBar.text = place.formattedAddress
        print("Place name: \(place.name)")
        print("Place address: \(String(describing: place.formattedAddress))")
        print("Place attributions: \(place.attributions)")
//
        
        // Buttonを生成する
        let button = UIButton()
        button.frame = CGRect(x:0,y:0,width:200,height:40)
        
        button.backgroundColor = UIColor.blue
        button.layer.masksToBounds = true
        button.setTitle("Save Address", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.tag = 1
        
        button.layer.cornerRadius = 10.0
        button.layer.position = CGPoint(x: button.bounds.width/2
            , y:button.bounds.height/2)
        button.addTarget(self, action: #selector(self.onClick(_:)), for: .touchUpInside)
        button.center = self.view.center
        self.view.addSubview(button)
        
        
    }
    
    
    func onClick(_ sender: AnyObject){
        let button = sender as! UIButton
        
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in. Show home screen
                
                self.ref.child("users").child(user.uid).updateChildValues(["address": (self.searchController?.searchBar.text!)!])
//                self.ref.childByAutoId().setValue(["food": "yerd"])
                
            } else {
                // No User is signed in. Show user the login screen
                print("😄","nothing")
            }
        }
        
        
        
        // アラート表示
        let alert: UIAlertController = UIAlertController(title: "title", message: "It has saved!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            print("Action OK!!")
            
            self.dismiss(animated: true, completion: nil)
            
            let tbv: TabBarNaviViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarNaviView") as! TabBarNaviViewController
//            let navi = UINavigationController(rootViewController: tbv)
            tbv.modalTransitionStyle = .crossDissolve
            self.present(tbv, animated: true, completion: nil)
            
            
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    
}
