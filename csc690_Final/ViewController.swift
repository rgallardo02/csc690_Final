//
//  ViewController.swift
//  csc690_Final
//
//  Created by Rodrigo Gallardo and German Perez on 11/17/20.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func returnLocation(_ sender: Any) {

       // let carLocation = defaults.String(forKey: "location")
        print("CarLocation:")
        
    }
  
    fileprivate let locationManager: CLLocationManager = {
      let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setUpMapView()
        self.locationManager.requestAlwaysAuthorization()
        
        mapView.delegate = self
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
        mapView.addGestureRecognizer(longTapGesture)
        
    }
    
    @objc func longTap(sender: UIGestureRecognizer){
        print("long tap")
        if sender.state == .began {
            let locationInView = sender.location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            addAnnotation(location: locationOnMap)
        }
    }

    func addAnnotation(location: CLLocationCoordinate2D){
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = "Save Address"
            self.mapView.addAnnotation(annotation)
    }
    
    func setUpMapView(){
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.showsScale = true
        currentLocation()
    }
    
    func currentLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 11.0, *){
            locationManager.showsBackgroundLocationIndicator = true
        }else {
            
        }
        locationManager.startUpdatingLocation()
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let location = locations.last! as CLLocation
        let currentLocation = location.coordinate
        let coordinateRegion = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(coordinateRegion, animated: true)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print(error.localizedDescription)
    }
    
}

extension ViewController: MKMapViewDelegate{

func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard annotation is MKPointAnnotation else { print("no mkpointannotaions"); return nil }

    let reuseId = "pin"
    var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

    if pinView == nil {
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView!.canShowCallout = true
        pinView!.rightCalloutAccessoryView = UIButton(type: .infoDark)
        pinView!.pinTintColor = UIColor.blue
    }
    else {
        pinView!.annotation = annotation
    }
    return pinView
}

func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    print("tapped on pin ")
    
}


func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    if control == view.rightCalloutAccessoryView {
        if (view.annotation?.title!) != nil {
            
            print("do something")
        }
    }
  }
    
}

extension UserDefaults{

    func set(location: CLLocation, forKey key: String){
        let locationLat = NSNumber(value:location.coordinate.latitude)
        let locationLon = NSNumber(value: location.coordinate.longitude)
        self.set(["lat": locationLat, "lon": locationLon], forKey: key)
    }

    func location(forKey key: String) -> CLLocation?
    {
        if let locationDictionary = self.object(forKey: key) as? Dictionary<String,NSNumber>{
            let locationLat = locationDictionary["lat"]!.doubleValue
            let locationLon = locationDictionary["Lon"]!.doubleValue
            return CLLocation(latitude: locationLat, longitude: locationLon)
        }
        return nil

    }
}
