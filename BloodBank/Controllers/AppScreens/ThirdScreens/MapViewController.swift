//
//  MapViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 07/02/2022.
//

import UIKit
import MapKit
import CoreLocation
class MapViewController: UIViewController {
    
    //MARK: -  variables
    
    @IBOutlet weak var mapView: MKMapView!
     
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.requestWhenInUseAuthorization()
        displayMaltipleLocations()
        locationManager.startUpdatingLocation()
    }
    //MARK: - private functions
        // for pins
    func displayMaltipleLocations(){
        for location in LocationCoordinate.locations{
            let annotaion = MKPointAnnotation()
            annotaion.title = location["title"] as? String
            annotaion.subtitle = location["description"] as? String
            annotaion.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
            mapView.addAnnotation(annotaion)
        }
    }
}
// for custom pin
extension MapViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else{
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        if annotationView == nil{
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
        }else{
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "blood-drop")
        return annotationView
        
    }
}
