//
//  Helpers.swift
//  DealStore
//
//  Created by ios on 19/01/20.
//  Copyright © 2020 ios. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

extension JSONDecoder {
    static func decodeInStyle<T>(_ type: T.Type, from data: Data) -> T? where T: Decodable {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(T.self, from: data)
            return response
        } catch let DecodingError.keyNotFound(key, context) {
            print("ERROR Key: '\(key)' not found")
            print("Parsing Error codingPath: '\(context.codingPath)' ")
        } catch let DecodingError.valueNotFound(value, context) {
            print("ERROR parsing Value: '\(value)' not found")
            print("Parsing Error codingPath: '\(context.codingPath)' ")
        } catch let DecodingError.typeMismatch(type, context) {
            print("ERROR Parsing type: '\(type)' not found")
            print("Parsing Error codingPath: '\(context.codingPath)' ")
        } catch {
            print("ERROR : '\(error)'")
        }
        return nil
     }
}

class Helpers: NSObject {
    
    static func openMapsFor(placeName name: String, location coords: CLLocationCoordinate2D) {

        let regionDistance:CLLocationDistance = 10000
        let regionSpan = MKCoordinateRegion(center: coords, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coords, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        mapItem.openInMaps(launchOptions: options)
    }
    
    static func showAlert(withTitle title: String, withMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (act) in
            alert.dismiss(animated: true, completion: nil)
        }))
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            
        }
    }
    static func showAlertWithAction(withTitle title: String, withMessage message: String, completion: @escaping ()->Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (act) in
            alert.dismiss(animated: true, completion: nil)
            completion()
        }))
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            
        }
    }

    static func showAlertWithYesNoAction(withTitle title: String, withMessage message: String, completion: @escaping ()->Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: { (act) in
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (act) in
            alert.dismiss(animated: true, completion: nil)
            completion()
        }))
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            
        }
    }

    static func showErrorAlert(withMessage message: String) {
        showAlert(withTitle: "Error!", withMessage: message)
    }

    static func showDefaultErrorAlert() {
        showAlert(withTitle: "Error!", withMessage: "Something went wrong. Please try again later.")
    }

    static func showSuccessAlert(withMessage message: String) {
        showAlert(withTitle: "Success!", withMessage: message)
    }

    class func delay(_ delay:Double, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
}
