//
//  BookingAppointmentViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 25/02/2022.
//

import UIKit
import MapKit
import CoreLocation
//MARK: - Variables
class BookingAppointmentViewController: UIViewController {
    @IBOutlet weak var bookingMapView: MKMapView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var bankAddressLabel: UILabel!
    @IBOutlet weak var getDirectionBtn: UIButton!
    //MARK: - Variables
    var locationManager = CLLocationManager()
    var coordinatePin: CLLocationCoordinate2D?
    var directionArray: [MKDirections] = []
    //MARK: - LifeCycle
    override func viewDidLoad(){
        super.viewDidLoad()
        bookingMapView.delegate = self
        locationManager.delegate = self
        setAllLocationService()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpDesign()
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
            bookingMapView.addAnnotation(annotaion)
        }
    }
    private func test(coordinate: CLLocationCoordinate2D)-> CLLocationCoordinate2D?{
        for location in LocationCoordinate.locations{
            let annotaion = MKPointAnnotation()
            annotaion.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
            print(annotaion.coordinate)
            return coordinate
        }
        return nil
    }
    private func setUpDesign(){
//        title = "حجز موعد للتبرع"
        self.getDirectionBtn.titleLabel?.font = UIFont(name: "Almarai", size: 18)
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1) , .font: UIFont(name: "Almarai-Bold", size: 20)!]
        self.view.backgroundColor =  #colorLiteral(red: 0.9845134616, green: 0.9810839295, blue: 0.9719126821, alpha: 1)
        navigationItem.backButtonTitle = ""
        navigationItem.backBarButtonItem?.isEnabled = false
        self.tabBarController?.tabBar.isHidden = true
        self.detailsView.isHidden = true
        self.getDirectionBtn.isHidden = true
//        self.navigationController?.navigationBar.isHidden = true
        
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
                self.bookingMapView.addOverlay(route.polyline)
                self.bookingMapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
     func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
         render.strokeColor = .darkGray
        return render
    }
     func resetMapView(withNew direction: MKDirections){
        bookingMapView.removeOverlays(bookingMapView.overlays)
        directionArray.append(direction)
        let _ = directionArray.map {$0.cancel()}
        
    }
    //MARK: - Actions
    @IBAction func pickDateTimeBtnTapped(_ sender: UIButton) {
        navigationController?.pushViewController(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PickDateTimeViewController")as! PickDateTimeViewController, animated: true)
    }
    @IBAction func getDirectionsBtnTapped(_ sender: UIButton) {
        if let userLoc = locationManager.location{
            self.drawDirections(startingLoc: userLoc.coordinate, destinationLoc: coordinatePin!)
            // or
            //if i wanna select direction with the pin(i will hide this pin now)
//            self.drawDirections(startingLoc: userLoc.coordinate, destinationLoc: bookingMapView.centerCoordinate)
        }
    }
}
//MARK: - All Extensions
// for custom pin MKMapViewDelegate
extension BookingAppointmentViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else{
            return nil
        }
//        or
//        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "custom")
//        annotationView.canShowCallout = true
//        annotationView.glyphImage = UIImage(named: "bloodPin2")
//        annotationView.markerTintColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
//        annotationView.selectedGlyphImage = UIImage(named: "bloodPin")
//
//        return annotationView
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        if annotationView == nil{
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
        }else{
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "bloodPin")
        return annotationView
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
extension BookingAppointmentViewController: CLLocationManagerDelegate{
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
            bookingMapView.showsUserLocation = true
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            bookingMapView.showsUserLocation = true
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
            bookingMapView.showsUserLocation = true
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            bookingMapView.showsUserLocation = true
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
        bookingMapView.setRegion(region, animated: true)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            print("location \(location.coordinate)")
            zoomUserLocation(location: location)
        }
        locationManager.stopUpdatingLocation()
    }
}
