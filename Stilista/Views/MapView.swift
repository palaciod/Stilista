//
//  MapView.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/19/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class MapView: UIView {
    var stylistName: String?
    var long: Double?
    var lat: Double?
    var locationManager: CLLocationManager?
    let regionInMeters: Double = 1800
    
    let map: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    let centerCircle: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.6246554719, blue: 0.8705882353, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 2
        view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addSubview(map)
        setUpMap()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpMap(){
        map.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        map.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        map.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        map.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
    }
    
    private func setUpCustomCenter(){
        centerCircle.centerXAnchor.constraint(equalTo: map.centerXAnchor).isActive = true
        centerCircle.centerYAnchor.constraint(equalTo: map.centerYAnchor).isActive = true
        centerCircle.widthAnchor.constraint(equalTo: map.widthAnchor, multiplier: 0.05).isActive = true
        centerCircle.heightAnchor.constraint(equalTo: centerCircle.widthAnchor).isActive = true
    }
     func setLocation(){
        let center = CLLocationCoordinate2D.init(latitude: lat ?? 40.7128, longitude: long ?? -74.0060)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: 1500, longitudinalMeters: 1500)
        map.setRegion(region, animated: false)
        setPointAnnotationName()
    }
    
    func setPointAnnotationName(){
        let stylistLocation = MKPointAnnotation()
        stylistLocation.title = stylistName ?? "Stylist"
        stylistLocation.coordinate = CLLocationCoordinate2D(latitude: lat ?? 40.7128, longitude: long ?? -74.0060)
        map.addAnnotation(stylistLocation)
    }
    
    func setUpLocationManager(){
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        map.delegate = self
    }
    
    func checkLocationAuth(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            map.addSubview(centerCircle)
            setUpCustomCenter()
            centerViewOnUserLocation()
            print("When in use")
            break
        case .denied :
            // Show Alert
            print("Big fat No")
            break
        case .notDetermined:
            locationManager!.requestWhenInUseAuthorization()
            print("??????????")
            break
        case .restricted:
            // Show alert
            print("Restructed")
            break
        case .authorizedAlways:
            print("Always in use")
            map.addSubview(centerCircle)
            setUpCustomCenter()
            centerViewOnUserLocation()
            break
        @unknown default:
            fatalError()
        }
    }
    
    func centerViewOnUserLocation(){
        
        if let location = locationManager?.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            map.setRegion(region, animated: true)
            
        }else{
            print("Faileddedew")
        }
        
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            print("Location is enabled")
            setUpLocationManager()
            checkLocationAuth()
        }else{
            print("Location is disabled")
        }
    }
    
    private func getCenter(map: MKMapView) -> CLLocation{
        let lat = map.centerCoordinate.latitude
        let long =  map.centerCoordinate.longitude
        return CLLocation(latitude: lat, longitude: long)
    }
    
    
}

extension MapView: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("success")
        checkLocationAuth()
    }
}

extension MapView: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenter(map: mapView)
        long = center.coordinate.longitude
        lat = center.coordinate.latitude
    }
}


