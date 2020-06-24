//
//  MapVC.swift
//  NoteApp_Goal_Diggers_FP
//
//  Created by Gagan on 2020-06-22.
//  Copyright © 2020 Gagan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController , MKMapViewDelegate, CLLocationManagerDelegate  {
    
    
    @IBOutlet weak var mapview: MKMapView!
    
    
    var locationManager = CLLocationManager()
    var segueLongitude:Double!
    var segueLatitude:Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       mapview.delegate = self
               
               locationManager.delegate = self
               locationManager.desiredAccuracy = kCLLocationAccuracyBest
               locationManager.startUpdatingLocation()
               showSavedLocation()
               
           }
    
    
    @IBAction func btnShowRoute(_ sender: UIButton) {
    let dest = CLLocationCoordinate2D(latitude: segueLatitude, longitude: segueLongitude)
               getRoute(destination: dest)
           }
    @IBAction func navButtonPressed(_ sender: UIButton) {
   let dest = CLLocationCoordinate2D(latitude: segueLatitude, longitude: segueLongitude)
            getDirection(dest: dest)
            
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func showSavedLocation(){
            
            let span = MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
            let location = CLLocationCoordinate2D(latitude: segueLatitude!, longitude: segueLongitude!)
            
            let region = MKCoordinateRegion(center: location, span: span)
            mapview.setRegion(region, animated: true)
            
            let annotation = CustomAnno(coordinate: location, identifier: "pinAnnotation")
            
            //        annotation.coordinate = location
            mapview.addAnnotation(annotation)
        }
        
        
        func getRoute(destination:CLLocationCoordinate2D ){
            
            let destinationRequest = MKDirections.Request()
            let sourceCoordinates = mapview.userLocation.coordinate
            
            let source = CLLocationCoordinate2DMake((sourceCoordinates.latitude), (sourceCoordinates.longitude))
            let destination = CLLocationCoordinate2DMake(destination.latitude, destination.longitude)
            
            let sourcePlacemark = MKPlacemark(coordinate: source)
            let destinationPlacemark = MKPlacemark(coordinate: destination)
            
            let finalSource = MKMapItem(placemark: sourcePlacemark)
            let finalDestination = MKMapItem(placemark: destinationPlacemark)
            
            destinationRequest.source = finalSource
            destinationRequest.destination = finalDestination
            destinationRequest.transportType = .automobile
            
            let direction = MKDirections(request: destinationRequest)
            
            direction.calculate { (responce, error) in
                
                guard let responce = responce else {
                    if let error = error {
                        print(error)
                        
                    }
                    return
                }
                let route = responce.routes[0]
                
                self.mapview.addOverlay(route.polyline, level: .aboveRoads)
                self.mapview.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                
                
            }
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            
            if overlay is MKPolyline{
                
                let renderer = MKPolylineRenderer(overlay: overlay)
                
                renderer.strokeColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
                renderer.lineWidth = 2
                
                return renderer
                
            }
            return MKOverlayRenderer()
        }
        
        func getDirection(dest: CLLocationCoordinate2D){
            
            let source = MKMapItem(placemark:MKPlacemark(coordinate: mapview.userLocation.coordinate))
            let dest = MKMapItem(placemark: MKPlacemark(coordinate: dest))
            
            MKMapItem.openMaps(with: [source , dest], launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving ])
            
        }
        
        
        
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation{
                return nil
            }
            
            let ann = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pinAnnotation")
            
            return ann
            
        }
        
        override func viewWillAppear(_ animated: Bool) {
            navigationController?.isToolbarHidden = true
        }
        override func viewWillDisappear(_ animated: Bool) {
            navigationController?.isToolbarHidden = false
        }
        
        
    }


