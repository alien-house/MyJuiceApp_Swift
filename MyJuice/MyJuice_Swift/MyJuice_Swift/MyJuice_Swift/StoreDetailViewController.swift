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

class StoreDetailViewController: UIViewController, GMSMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var mapView : GMSMapView!
    var atai:AnyObject?
    var storeData = Dictionary<String,Any>()
    var storeDataArray = [String]()
    var storeHours = Dictionary<String,Any>()
    
    @IBOutlet weak var DetailTable: UITableView!
    
    override func viewDidLoad() {
        
        //prepear the table
        self.DetailTable.delegate = self
        self.DetailTable.dataSource = self
        
        // get the data
        let myPlaceID:String = atai?["myPlaceID"] as! String
//        getJsonData(myPlaceID: myPlaceID)
        
        
//            self.getJsonData(myPlaceID: myPlaceID)
            
            //==========
            let str:String = "https://maps.googleapis.com/maps/api/place/details/json?placeid="+myPlaceID+"&key=AIzaSyDO5cG0reH45LHZ9Y-Vfw93uSUZQBH4r-g"
            let url = URL(string: str)
            let urlRequest = URLRequest(url: url!)
            
            let task = URLSession.shared.dataTask(with: urlRequest) {
                (data, response, error) in
                
                guard error == nil else {
                    print(error!)
                    return
                }
                guard let responseData = data else {
                    print("Error: did not receive data")
                    return
                }
                do {
                    guard let placeData = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.allowFragments)
                        as? [String: Any] else {
                            print("error trying to convert data to JSON")
                            return
                    }
                    
                    // print("The placeData is: \(placeData.description)")
                    
                    guard let name = (placeData["result"] as? [String : Any])?["name"] as? String else {
                        return
                    }
                    self.storeData["name"] = name
                    self.storeDataArray.append(name)
                    guard let formatted_address = (placeData["result"] as? [String : Any])?["formatted_address"] as? String else {
                        return
                    }
                    self.storeData["address"] = formatted_address
                    self.storeDataArray.append(formatted_address)
                    guard let formatted_phone_number = (placeData["result"] as? [String : Any])?["formatted_phone_number"] as? String else {
                        return
                    }
                    self.storeData["phone_number"] = formatted_phone_number
                    self.storeDataArray.append(formatted_phone_number)
                    guard let weekday_text = (placeData["result"] as? [String : Any])?["opening_hours"] as? NSDictionary else {
                        return
                    }
                    self.storeData["weekday_text"] = weekday_text["weekday_text"]
                    self.storeHours["weekday_text"] = weekday_text["weekday_text"]
//                    self.storeDataArray.append(weekday_text["weekday_text"])
                    
                    guard let geometry = (placeData["result"] as? [String : Any])?["geometry"] as? NSDictionary else {
                        return
                    }
                    print("geometry")
                    print(geometry)
                    self.storeData["location"] = geometry["location"]
                    
                    
                    print("ゲットした？ did you get it?")
                    
                    guard let website = (placeData["result"] as? [String : Any])?["website"] as? String else {
                        print("Could not get the website from JSON")
                        return
                    }
                    
                    // make the Queue, and excute as subthread
                    DispatchQueue(label: "com.myjuce.serial-queue").async {
                        
                        
                        // main thred
                        DispatchQueue.main.async {
                            print("main.async")
                            //                print(self.storeData["location"])
//                            print(self.storeData["location"])
                            let loc = self.storeData["location"]
                            //                print(loc["lat"]!)
                            print((loc as! Dictionary)["lat"]!)
                            //                //make map
                            self.makeMap(latitude: (loc as! Dictionary)["lat"]! ,longitude: (loc as! Dictionary)["lng"]!)
                            self.DetailTable.reloadData()
                        }
                    }

                    
                    
                    //                print("The title is: \(website)")
                } catch  {
                    print("error trying to convert data to JSON")
                    return
                }
            }
            task.resume()
            
            //==========
        
        
        
    }
    
    
    
    
    func makeMap(latitude:Double,longitude:Double){
        print("makeMap hello wagain")
        //mini map
        
        let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height
        
       
        
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 17.0)
        let frame:CGRect = CGRect(x: 0, y: statusBarHeight+(navBarHeight! as CGFloat), width: self.view.frame.width, height: 200)
        self.mapView = GMSMapView.map(withFrame: frame, camera: camera)
        self.view.addSubview(self.mapView!)
        self.mapView.delegate = self
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude:longitude)
        marker.map = self.mapView
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        if let cell:StoreDetailTableCell = tableView.dequeueReusableCell(withIdentifier: "StoreDetailTableCellID") as? StoreDetailTableCell {
            
            print(indexPath.row)
            print(self.storeDataArray)
            if(!self.storeDataArray.isEmpty){
                if indexPath.row == 3{
                    print("print(self.storeHours.count)")
                    print( String(describing: type(of: self.storeHours["weekday_text"])))
                   let JSON = self.storeHours["weekday_text"] as! NSArray
                    print(JSON[0])
//                    cell.DetailLabel.text = self.storeData["weekday_text"][0]
                }else{
                    cell.DetailLabel.text = self.storeDataArray[indexPath.row]
                }
            }
//            cell.DetailLabel.text = "ddddd"
//            print("いつ？")
            
            return cell
        }
        
        
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return "What a What aWhat a"
    }
    
    
    
    
    @IBAction func DetailCancelBtn(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    func getJsonData(myPlaceID:String){
        
        
        let str:String = "https://maps.googleapis.com/maps/api/place/details/json?placeid="+myPlaceID+"&key=AIzaSyDO5cG0reH45LHZ9Y-Vfw93uSUZQBH4r-g"
        let url = URL(string: str)
        let urlRequest = URLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) {
            (data, response, error) in
            
            guard error == nil else {
                print(error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            do {
                guard let placeData = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.allowFragments)
                    as? [String: Any] else {
                        print("error trying to convert data to JSON")
                        return
                }
                
                // print("The placeData is: \(placeData.description)")
                
                
                print("==================")
                guard let name = (placeData["result"] as? [String : Any])?["name"] as? String else {
                    return
                }
                print(name)
                guard let formatted_address = (placeData["result"] as? [String : Any])?["formatted_address"] as? String else {
                    return
                }
                print(formatted_address)
                guard let formatted_phone_number = (placeData["result"] as? [String : Any])?["formatted_phone_number"] as? String else {
                    return
                }
                print(formatted_phone_number)
                guard let weekday_text = (placeData["result"] as? [String : Any])?["opening_hours"] as? NSDictionary else {
                    return
                }
                print(weekday_text["weekday_text"])
                print("==================")
                
                
                
                guard let website = (placeData["result"] as? [String : Any])?["website"] as? String else {
                    print("Could not get the website from JSON")
                    return
                }
                
                //                var dates:[String:String] = ["formatted_phone_number":formatted_phone_number]
                self.storeData["formatted_phone_number"] = formatted_phone_number
                
                print("データ取れるとこ")
                //                print("The title is: \(website)")
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
        
        
        
        
    }
    

    
    
    
    
}
