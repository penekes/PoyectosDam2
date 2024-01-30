//
//  ViewController.swift
//  Mapas
//
//  Created by dam2 on 18/1/24.
//

import UIKit
import MapKit


class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    
    @IBOutlet weak var mapView: MKMapView!

  
    @IBAction func switchOnLlinares(_ sender: UISwitch) {
        showOnlyLinares = sender.isOn
        updateAnnotationsVisibility()
        
    }
    
    
    let locationManager = CLLocationManager()
    var showOnlyLinares = false
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        centerMapOnElPosito()

        addMarkers()
        
    }
    
    func addMarkerElPosito() {
       
        
        let elPositoLocation = CLLocationCoordinate2D(latitude: 38.096924 , longitude: -3.632921) //Coordenadas de "El Pósito"
             
        let annotation = MKPointAnnotation()
        annotation.coordinate = elPositoLocation
        annotation.title = "El Pósito"
             
        mapView.addAnnotation(annotation)
        mapView.selectAnnotation(annotation, animated: true)
        mapView.view(for: annotation)?.isHidden = showOnlyLinares
    }
    
    
    func addMarkerForSchool() {
        
        let schoolLocation = CLLocationCoordinate2D(latitude: 38.096000, longitude: -3.631000) //Coordenadas de la escuela

        let annotation = MKPointAnnotation()
        annotation.coordinate = schoolLocation
        annotation.title = "Escuela ESTECH"

        mapView.addAnnotation(annotation)
        mapView.view(for: annotation)?.isHidden = showOnlyLinares
       
       
    }
    
    func addMarkerCatedralBaeza() {
        
        let cathedralLocation = CLLocationCoordinate2D(latitude:37.9936, longitude: -3.4685) //Coordenadas de la Catedral de Baeza

        let annotation = MKPointAnnotation()
        annotation.coordinate = cathedralLocation
        annotation.title = "Catedral de Baeza"

        mapView.addAnnotation(annotation)
        mapView.view(for: annotation)?.isHidden = showOnlyLinares
        
    }
    
    func centerMapOnElPosito() {
         let elPositoLocation = CLLocationCoordinate2D(latitude: 38.096924, longitude: -3.632921)
    
         let regionRadius: CLLocationDistance = 37000

         let region = MKCoordinateRegion(center: elPositoLocation,  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
         mapView.setRegion(region, animated: true)
     }
    
    
    
    func openMapsAppWithDirections(to destination: MKAnnotation) {
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: destination.coordinate, addressDictionary: nil))
        mapItem.name = destination.title ?? "Destination"

        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
        mapItem.openInMaps(launchOptions: launchOptions)
    }
    
    //variable diferenciadora
 
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "marker"
            var annotationView: MKPinAnnotationView?

            if let title = annotation.title, title == "Catedral de Baeza" {
                annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
                if annotationView == nil {
                    annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                    annotationView?.pinTintColor = UIColor.yellow
                }
            } else {
                annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
                if annotationView == nil {
                    annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                }
            }

            annotationView?.canShowCallout = true
            let directionsButton = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = directionsButton

            return annotationView
        }



//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        guard let annotation = annotation as? MKPointAnnotation else { return nil }
//
//        let identifier = "marker"
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//
//        if annotationView == nil {
//            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            annotationView?.canShowCallout = true
//            let directionsButton = UIButton(type: .detailDisclosure)
//            annotationView?.rightCalloutAccessoryView = directionsButton
//        } else {
//            annotationView?.annotation = annotation
//        }
//
//        return annotationView
//    }

    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let title = view.annotation?.title {
            if title == "Escuela ESTECH" {
                openWebsite()
            } else if title == "Catedral de Baeza", control == view.rightCalloutAccessoryView {
                openMapsAppWithDrivingDirections()
            } else if title == "El Pósito", control == view.rightCalloutAccessoryView {
                openMapsAppWithWalkingDirections()
            }
        }
    }
    
    func openMapsAppWithWalkingDirections() {
        let elPositoLocation = CLLocationCoordinate2D(latitude: 38.096924, longitude: -3.632921)
        let elPositoPlacemark = MKPlacemark(coordinate: elPositoLocation, addressDictionary: nil)
        
        let mapItem = MKMapItem(placemark: elPositoPlacemark)
        mapItem.name = "El Pósito"
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
        mapItem.openInMaps(launchOptions: launchOptions)
    }
    
    func openMapsAppWithDrivingDirections() {
        let cathedralLocation = CLLocationCoordinate2D(latitude: 37.9936, longitude: -3.4685)
        let cathedralPlacemark = MKPlacemark(coordinate: cathedralLocation, addressDictionary: nil)
        
        let mapItem = MKMapItem(placemark: cathedralPlacemark)
        mapItem.name = "Catedral de Baeza"
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: launchOptions)
    }

    func openWebsite() {
        if let url = URL(string: "https://escuelaestech.es") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
   
    
    func addMarkers() {
        addMarkerElPosito()
        addMarkerForSchool()
        addMarkerCatedralBaeza()
    }
    
//    func updateAnnotationsVisibility() {
//        for annotation in mapView.annotations {
//            if let title = annotation.title {
//                if title == "Catedral de Baeza" {
//                    mapView.view(for: annotation)?.isHidden = !showOnlyLinares
//                } else {
//                    mapView.view(for: annotation)?.isHidden = false
//                }
//            }
//        }
//    }
    
//    func updateAnnotationsVisibility() {
//        var visibleAnnotations = mapView.annotations
//
//        if showOnlyLinares {
//            // Filtrar las anotaciones para mostrar solo las relacionadas con "Catedral de Baeza"
//            visibleAnnotations = visibleAnnotations.filter { $0.title == "Catedral de Baeza" }
//        }
//
//        // Ajustar la región para incluir todas las anotaciones visibles
//        mapView.showAnnotations(visibleAnnotations, animated: true)
//    }



    func updateAnnotationsVisibility() {
        // Filtrar las anotaciones según el estado del interruptor
        var visibleAnnotations = mapView.annotations
        if showOnlyLinares {
            visibleAnnotations = visibleAnnotations.filter { $0.title == "El Pósito" }
        }

        // Calcular una región que contenga todas las anotaciones visibles
        var region: MKCoordinateRegion?

        if let firstAnnotation = visibleAnnotations.first {
            var minLat = firstAnnotation.coordinate.latitude
            var maxLat = firstAnnotation.coordinate.latitude
            var minLon = firstAnnotation.coordinate.longitude
            var maxLon = firstAnnotation.coordinate.longitude

            for annotation in visibleAnnotations {
                minLat = min(minLat, annotation.coordinate.latitude)
                maxLat = max(maxLat, annotation.coordinate.latitude)
                minLon = min(minLon, annotation.coordinate.longitude)
                maxLon = max(maxLon, annotation.coordinate.longitude)
            }

            let center = CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2, longitude: (minLon + maxLon) / 2)
            let span = MKCoordinateSpan(latitudeDelta: maxLat - minLat, longitudeDelta: maxLon - minLon)
            region = MKCoordinateRegion(center: center, span: span)
        }

        // Ajustar la región del mapa si se pudo calcular
        if let region = region {
            mapView.setRegion(region, animated: true)
        }
    }



   
}

