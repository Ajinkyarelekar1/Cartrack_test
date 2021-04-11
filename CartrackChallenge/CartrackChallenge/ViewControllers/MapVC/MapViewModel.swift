//
//  MapViewModel.swift
//  CartrackChallenge
//
//  Created by venajr on 12/4/21.
//

import Foundation
import UIKit
import MapKit

class MapViewModel: NSObject {
    var strLat = ""
    var strLong = ""
    
    func updateLatLong(lat: String, lng: String) {
        strLat = lat
        strLong = lng
    }
    
    func addPin(mapView: MKMapView) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: (Double(strLat) ?? 0), longitude: (Double(strLong) ?? 0))
        mapView.addAnnotation(annotation)
        mapView.delegate = self
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
        mapView.region = region
    }
}

extension MapViewModel: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseID = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID) as? MKPinAnnotationView
        if(pinView == nil) {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            let annot = annotation as! MKPointAnnotation
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            pinView?.accessibilityLabel = annot.accessibilityLabel
            let selectedLabel = UILabel()
            selectedLabel.text = annot.accessibilityLabel
            selectedLabel.textAlignment = .center
            selectedLabel.numberOfLines = 0
            selectedLabel.backgroundColor = UIColor.white
            selectedLabel.layer.borderColor = UIColor.darkGray.cgColor
            selectedLabel.layer.borderWidth = 2
            selectedLabel.layer.cornerRadius = 5
            selectedLabel.layer.masksToBounds = true
            selectedLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let verticalConstraint = NSLayoutConstraint(item: selectedLabel, attribute: .bottom, relatedBy: .equal, toItem: pinView, attribute: .top, multiplier: 1, constant: -10)
            let centerConstraint = NSLayoutConstraint(item: selectedLabel, attribute: .centerX, relatedBy: .equal, toItem: pinView, attribute: .centerX, multiplier: 1, constant: 0)
            let widthConstraint = NSLayoutConstraint(item: selectedLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 150)
            
            pinView?.addSubview(selectedLabel)
            
            pinView?.addConstraints([verticalConstraint, centerConstraint, widthConstraint])
        }
        return pinView
    }
}
