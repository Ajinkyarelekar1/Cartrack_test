//
//  MapVC.swift
//  CartrackChallenge
//
//  Created by venajr on 12/4/21.
//

import UIKit
import MapKit

class MapVC: BaseViewController {
    @IBOutlet weak var mapView: MKMapView!
    let viewModel = MapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.addPin(mapView: mapView)
        
    }
    
    func updateLatLong(lat: String, lng: String) {
        viewModel.updateLatLong(lat: lat, lng: lng)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
