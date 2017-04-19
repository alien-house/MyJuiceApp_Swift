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
    let placeIDs = ["ChIJEenQuNNzhlQRYBLvIjoqPJE","ChIJdd9ipdNzhlQRTeCkanpMc8s","ChIJ5_L29tNzhlQR84NgJCxQ8j4"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placesClient = GMSPlacesClient.shared()
        print("viewDidLoad")
        
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        }
        
        loadViews()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.stopUpdatingLocation()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadViews() {
        print("loadView")
        // Create a GMSCameraPosition that tells the map to display the
        
        let camera = GMSCameraPosition.camera(withLatitude: 49.277143, longitude: -123.129742, zoom: 16.0)
        
        self.mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        self.mapView.settings.myLocationButton = true
        self.mapView.isMyLocationEnabled = true
        view = self.mapView
        self.mapView.delegate = self // why here...? otherwise error will be occured
        
        
        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = self.mapView
//        
        
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
                    print("Place name \(p.name)")
                    print("Place address \(String(describing: p.formattedAddress))")
                    print("Place placeID \(p.placeID)")
                    print("Place coordinate \(p.coordinate.latitude)")
                    
                    let marker = GMSMarker()
//                    marker.isFlat = true
                    marker.position = CLLocationCoordinate2D(latitude: p.coordinate.latitude, longitude: p.coordinate.longitude)
                    marker.title = p.name
                    let myPlaceDic:[String:String] = ["myPlaceID" : p.placeID]
                    marker.userData = myPlaceDic
//                    marker.userData = String("placeID": "Hello")
                    
                    marker.snippet = p.formattedAddress
                    marker.map = self.mapView
                    
                } else {
                    print("No place details for \(placeID)")
                }
            })
        }
        locationManager.stopUpdatingLocation()
        
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
//
//        let marker_now = GMSMarker()
//        marker_now.isFlat = true
//        marker_now.position = CLLocationCoordinate2D(latitude: newLocation.coordinate.latitude, longitude:newLocation.coordinate.longitude)
//        marker_now.title = "MyJuice Modate store"
//        marker_now.snippet = "kokoa"
//        marker_now.map = self.mapView
        
    }
    
    
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
//        print((marker.userData as AnyObject)["placeID"])

        let StoreDetailViewController: StoreDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "StoreDetail") as! StoreDetailViewController
        
        StoreDetailViewController.atai = marker.userData as AnyObject
        
        //normal transit page
        //present(StoreDetailViewController, animated: true, completion: nil)
        
        let navi = UINavigationController(rootViewController: StoreDetailViewController)
        // setting animation
         navi.modalTransitionStyle = .crossDissolve
        present(navi, animated: true, completion: nil)
        
        
        
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print("着てる？")
//    }
    
    
    
    
    
    
    
    
    
    // --
    
//    @IBAction func getCurrentPlace(_ sender: UIButton) {
//        
//        
//        //        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
//        //            if let error = error {
//        //                print("Pick Place error: \(error.localizedDescription)")
//        //                return
//        //            }
//        //
//        //            self.nameLabel.text = "No current place"
//        //            self.addressLabel.text = ""
//        //
//        //            if let placeLikelihoodList = placeLikelihoodList {
//        //                let place = placeLikelihoodList.likelihoods.first?.place
//        //                if let place = place {
//        //                    self.nameLabel.text = place.name
//        //                    self.addressLabel.text = place.formattedAddress?.components(separatedBy: ", ")
//        //                        .joined(separator: "\n")
//        //                }
//        //            }
//        //        })
//        
//        
//        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
//            if let error = error {
//                print("Pick Place error: \(error.localizedDescription)")
//                return
//            }
//            
//            if let placeLikelihoodList = placeLikelihoodList {
//                for likelihood in placeLikelihoodList.likelihoods {
//                    let place = likelihood.place
//                    print("Current Place name \(place.name) at likelihood \(likelihood.likelihood)")
//                    print("Current Place address \(place.formattedAddress)")
//                    print("Current Place attributions \(place.attributions)")
//                    print("Current PlaceID \(place.placeID)")
//                }
//            }
//        })
//        
//    }
    

    
}





