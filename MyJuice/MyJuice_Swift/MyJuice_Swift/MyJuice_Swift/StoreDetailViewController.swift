//
//  StoreDetailViewController.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/04/11.
//  Copyright © 2017年 shinji. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
import GooglePlacePicker
import Alamofire
import SwiftyJSON
import SVProgressHUD

class StoreDetailViewController: UIViewController, GMSMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var mapView : GMSMapView!
    var atai:AnyObject?
//    var storeData :<String,Any>()
    var storeData = [String: Double]()
    var storeDataArray = [String]()
    var storeHours = [String]()
    var arrRes = [[String:AnyObject]]()
    
    @IBOutlet weak var DetailTable: UITableView!
    
    override func viewDidLoad() {
        
        //prepear the table
        self.DetailTable.delegate = self
        self.DetailTable.dataSource = self
        self.DetailTable.estimatedRowHeight = 60
        self.DetailTable.rowHeight = UITableViewAutomaticDimension
        
        // get the data
        let myPlaceID:String = atai?["myPlaceID"] as! String
        
        //==========
        let str:String = "https://maps.googleapis.com/maps/api/place/details/json?placeid="+myPlaceID+"&key=AIzaSyDO5cG0reH45LHZ9Y-Vfw93uSUZQBH4r-g"
        let url = URL(string: str)
//        let urlRequest = URLRequest(url: url!)
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        
        
        Alamofire.request(url!).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resDataName = swiftyJsonVar["result"]["name"].string {
                    self.storeDataArray.append(resDataName)
                }
                if let resDataAddress = swiftyJsonVar["result"]["formatted_address"].string {
                    self.storeDataArray.append(resDataAddress)
                }
                if let resDataPhone = swiftyJsonVar["result"]["formatted_phone_number"].string {
                    self.storeDataArray.append(resDataPhone)
                }
                if let resDataWeekday = swiftyJsonVar["result"]["opening_hours"]["weekday_text"].arrayObject {
                    self.storeHours = resDataWeekday as! [String]
                }
                if let geometry = swiftyJsonVar["result"]["geometry"]["location"].dictionary{
                    let geo: [String: Double] = [
                        "lat": geometry["lat"]!.doubleValue,
                        "lng": geometry["lng"]!.doubleValue
                    ]
                    self.storeData = geo
                }
                
                DispatchQueue(label: "com.myjuce.serial-queue").async {
                    
                    DispatchQueue.main.async {
                        let loc = self.storeData
                        self.makeMap(latitude: loc["lat"]!, longitude: loc["lng"]!)
                        self.DetailTable.reloadData()
                        SVProgressHUD.dismiss()
                    }
                    
                }
                
            }
        }
        
    }
    
    
    func makeMap(latitude:Double,longitude:Double){
        
        let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 17.0)
        let frame:CGRect = CGRect(x: 0, y: statusBarHeight+(navBarHeight! as CGFloat), width: self.view.frame.width, height: 200)
        self.mapView = GMSMapView.map(withFrame: frame, camera: camera)
        self.view.addSubview(self.mapView!)
        self.mapView.delegate = self
        
        DetailTable.frame.origin = CGPoint(x: 0, y: 0)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude:longitude)
        marker.map = self.mapView
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        if let cell:StoreDetailTableCell = tableView.dequeueReusableCell(withIdentifier: "StoreDetailTableCellID") as? StoreDetailTableCell {
            
            if(!self.storeDataArray.isEmpty){
                if indexPath.row == 3{
                    
                    var hourString:String = ""
                    for (_, value) in self.storeHours.enumerated() {
                        hourString += (value + "\n")
                    }
                    cell.DetailLabel.text = hourString
                    
                }else{
                    print(self.storeDataArray[indexPath.row])
                    cell.DetailLabel.text = self.storeDataArray[indexPath.row]
                }
                cell.DetailLabel!.numberOfLines = 0
                cell.DetailLabel.sizeToFit()
                cell.DetailLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
            }
            
            return cell
        }
        
        
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    @IBAction func DetailCancelBtn(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
