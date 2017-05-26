//
//  ChooseStore.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/04/06.
//  Copyright © 2017年 shinji. All rights reserved.
//
// http://qiita.com/The_Shimon/items/6c3d6bcd6bfffbfd970d

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
import GooglePlacePicker

class StoreViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    var locationManager: CLLocationManager!
    var mapView : GMSMapView!
    var placesClient: GMSPlacesClient!
    var atai:AnyObject?
    
    //Lcation(Place ID) of The Brunch Store'
    let placeIDs = ["ChIJEenQuNNzhlQRYBLvIjoqPJE","ChIJuTxh_YJxhlQRNCKoNQhqDDs","ChIJ5_L29tNzhlQR84NgJCxQ8j4","ChIJnSkcknhxhlQR8PhwzwBejQw"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.locationServicesEnabled() {
            print("ゞlocationServicesEnabled")
            self.locationManager = CLLocationManager()
            self.locationManager.delegate = self
            self.locationManager.startUpdatingLocation()
        }
        
        let status = CLLocationManager.authorizationStatus()
        print("authorizationStatus:\(status)");
        if(status == .notDetermined) {
            self.locationManager.requestWhenInUseAuthorization()
        }
        
        
        let camera = GMSCameraPosition.camera(withLatitude: 49.277143, longitude: -123.129742, zoom: 16.0)
        
        self.mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        self.mapView.settings.myLocationButton = true
        self.mapView.isMyLocationEnabled = true
        view = self.mapView
        self.mapView.delegate = self         
        loadViews()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if CLLocationManager.locationServicesEnabled() {
//            locationManager.stopUpdatingLocation()
        }
    }
    
    
    func loadViews() {
        print("loadView")
  
        placesClient = GMSPlacesClient.shared()
        // A hotel in Saigon with an attribution.
        let placeID = "ChIJEenQuNNzhlQRYBLvIjoqPJE"
        
        for placeName in placeIDs {
            print("placeName:",placeName)
            
            placesClient.lookUpPlaceID(placeName, callback: { (place, error) -> Void in
                if error != nil {
                    print("lookup place id query error: \(error!.localizedDescription)")
                    return
                }
                
                if let p = place {
                    
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: p.coordinate.latitude, longitude: p.coordinate.longitude)
                    marker.title = p.name
                    let myPlaceDic:[String:String] = ["myPlaceID" : p.placeID]
                    marker.userData = myPlaceDic
                    
                    marker.snippet = p.formattedAddress
                    marker.map = self.mapView
                    
                } else {
                    print("No place details for \(placeID)")
                }
            })
        }
        
    }
    
    
    // get a permission
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse:
            break
        }
    }
    
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let newLocation = locations.last,
            CLLocationCoordinate2DIsValid(newLocation.coordinate) else {
                print("Error");
                return
        }        
        let now = GMSCameraPosition.camera(withLatitude: newLocation.coordinate.latitude,
                                           longitude:newLocation.coordinate.longitude,zoom:17)
        self.mapView.camera = now
        locationManager.stopUpdatingLocation()
        
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {

        let StoreDetailViewController: StoreDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "StoreDetail") as! StoreDetailViewController
        
        StoreDetailViewController.atai = marker.userData as AnyObject
        
        let navi = UINavigationController(rootViewController: StoreDetailViewController)
        // setting animation
         navi.modalTransitionStyle = .crossDissolve
        present(navi, animated: true, completion: nil)
        
    }
    
    
}





