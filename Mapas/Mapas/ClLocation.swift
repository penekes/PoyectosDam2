//
//  ClLocation.swift
//  Mapas
//
//  Created by dam2 on 18/1/24.
//


import UIKit
import CoreLocation

class ClLocation: UIViewController, CLLocationManagerDelegate{
    
    var locationManager : CLLocationManager?
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self

        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestLocation()
    }
    
    func requestLocation(){
        locationManager?.requestLocation()
    }
    
    func requestLocationUpdate(){
        locationManager?.startUpdatingLocation()
    }
    
    func stopLocationUpdate(){
        locationManager?.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            print("El usuario no lo ha decidido")
            locationManager?.requestAlwaysAuthorization()
        case .restricted:
            print("Restringido por control parental")
            locationManager?.requestAlwaysAuthorization()
        case .denied:
            print("El usuario ha rechazado el permiso")
            locationManager?.requestAlwaysAuthorization()
        case .authorizedWhenInUse:
            print("El usuario ha permitido usar la ubicacion mientras se usa la app")
            locationManager?.requestAlwaysAuthorization()
//            self.requestLocation()
            self.requestLocationUpdate()
        case .authorizedAlways:
            print("El usuario ha permitido usar la ubicación siempre")
            self.requestLocationUpdate()
            
        default:
            print("default")
        }
    }
    
    //en el INFO van todos los permisos. boton derecho open as/source code
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        print("latitud: \(location.coordinate.latitude), longitud: \(location.horizontalAccuracy)")
        if (location.horizontalAccuracy < 10){
            print("Precisión máxima")
            self.stopLocationUpdate()
        }
        
            

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Se ha producido un error: \(error.localizedDescription)")
    }
}

