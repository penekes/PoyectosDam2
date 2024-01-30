//
//  ArtWork.swift
//  Mapas
//
//  Created by dam2 on 18/1/24.
//

import Foundation
import MapKit
import Contacts

class ArtWork: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    let title: String?
    let locationName: String
    let discipline: String
    
    var subtitle: String?{
        return locationName
    }
    
    init(coordinate: CLLocationCoordinate2D, title: String?, locationName: String, discipline: String) {
        self.coordinate = coordinate
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        super.init()
    }
    
    func mapItem() -> MKMapItem {
        let addressDirt = [CNPostalAddressStreetKey: subtitle!]
        
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDirt)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
   
}
