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
    @IBOutlet weak var detailsView: UIView!
    
    @IBOutlet weak var bankAddressLabel: UILabel!
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var getDirectionBtn: UIButton!
    let locationManager = CLLocationManager()
    var coordinatePin: CLLocationCoordinate2D?
    var directionArray: [MKDirections] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailsView.isHidden = true
        self.getDirectionBtn.isHidden = true
        mapView.delegate = self
        locationManager.delegate = self
        self.setAllLocationService()
       
    }
    //MARK: - private functions
    private func setAllLocationService(){
        displayMaltipleLocations()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        if isLocationServicesEnabled(){
            checkAuthorization()
        }else{
            self.showAlert(title: "Sorry", message: "Please Enable location service")
        }
    }
    private func displayMaltipleLocations(){
        for location in LocationCoordinate.locations{
            let annotaion = MKPointAnnotation()
            annotaion.title = location["title"] as? String
            annotaion.subtitle = location["description"] as? String
            annotaion.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
            mapView.addAnnotation(annotaion)
        }
        
    }
        // Draw directions
         private func drawDirections(startingLoc: CLLocationCoordinate2D , destinationLoc: CLLocationCoordinate2D){
            let startingPlace = MKPlacemark(coordinate: startingLoc)
            let destinationPlace = MKPlacemark(coordinate: destinationLoc)
            
            let startingItem = MKMapItem(placemark: startingPlace)
            let destinationItem = MKMapItem(placemark: destinationPlace)
            
            let request = MKDirections.Request()
            request.source = startingItem
            request.destination = destinationItem
            request.transportType = .automobile
            
            let directions = MKDirections(request: request)
            self.resetMapView(withNew: directions)
            directions.calculate { response, error in
                guard let response = response else {
                    if let error = error{
                        print("direction error\(error.localizedDescription)")
                    }
                    return
                }
                for route in response.routes{
                    self.mapView.addOverlay(route.polyline)
                    self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                }
            }
        }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
       let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .darkGray
       return render
   }
    
    func resetMapView(withNew direction: MKDirections){
       mapView.removeOverlays(mapView.overlays)
       directionArray.append(direction)
       let _ = directionArray.map {$0.cancel()}
       
   }
    //MARK: - Actions
    @IBAction func getDirectionsBtnTapped(_ sender: UIButton) {
        if let userLoc = locationManager.location{
            self.drawDirections(startingLoc: userLoc.coordinate, destinationLoc: coordinatePin!)
            // or
            //if i wanna select direction with the pin(i will hide this pin now)
//            self.drawDirections(startingLoc: userLoc.coordinate, destinationLoc: bookingMapView.centerCoordinate)
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
        annotationView?.image = UIImage(named: "bloodPin")
        return annotationView
//        or
//        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "custom")
//        annotationView.canShowCallout = true
//        annotationView.glyphImage = UIImage(named: "bloodPin2")
//        annotationView.markerTintColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
//        annotationView.selectedGlyphImage = UIImage(named: "bloodPin")
//
//        return annotationView
       
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        detailsView.isHidden = false
        self.getDirectionBtn.isHidden = false
        bankNameLabel.text =  view.annotation?.title!
        bankAddressLabel.text = view.annotation?.subtitle!
        coordinatePin = view.annotation?.coordinate
    }
}

// user location & authorization CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate{
    private func isLocationServicesEnabled()-> Bool{
        return CLLocationManager.locationServicesEnabled()
    }
    private func checkAuthorization(){
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            break
        case .denied:
            showAlert(title: "", message: "please authorize access to location")
            break
        case .restricted:
            showAlert(title: "", message: "authorization restricted")
            break
        default:
            print("default..!")
            break
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            break
        case .denied:
            showAlert(title: "", message: "please authorize access to location")
            break
        default:
            print("default..!")
            break
        }
    }
    private func zoomUserLocation(location: CLLocation){
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 100000, longitudinalMeters: 100000)
        mapView.setRegion(region, animated: true)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            print("location \(location.coordinate)")
            zoomUserLocation(location: location)
        }
        locationManager.stopUpdatingLocation()
    }
}
