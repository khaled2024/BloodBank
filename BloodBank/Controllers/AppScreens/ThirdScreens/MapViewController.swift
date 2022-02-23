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
    let locations = [["title":"Tanta","latitude":30.4718,"longitude":31.0006,"description":"this is Mytown"],["title":"Cairo","latitude":30.033333,"longitude":31.233334,"description":"this is Cairo"],
                     ["title":"Alexandria","latitude":31.205753,"longitude":29.924526,"description":"this is Alexandria"]]
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // navigationController?.navigationBar.isHidden = true
        mapView.delegate = self
        displayMaltipleLocations()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    //MARK: - private functions
        // for pins
    func displayMaltipleLocations(){
        for location in locations{
            let annotaion = MKPointAnnotation()
            annotaion.title = location["title"] as? String
            annotaion.subtitle = location["description"] as? String
            annotaion.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
            mapView.addAnnotation(annotaion)
                        let region = MKCoordinateRegion(center: annotaion.coordinate, latitudinalMeters: 80000, longitudinalMeters: 80000)
                        mapView.setRegion(region, animated: true)
        }
    }
}

// for my location
extension MapViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let span = MKCoordinateSpan(latitudeDelta: 30.4718, longitudeDelta: 31.0006)
        let region = MKCoordinateRegion(center: locations[0].coordinate, span: span)
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
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
