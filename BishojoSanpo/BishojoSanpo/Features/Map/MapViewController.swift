//
//  MapViewController.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/09.
//

import GoogleMaps
import SwiftUI
import UIKit

class MapViewController: UIViewController {
    
    let map =  GMSMapView(frame: .zero, mapID: GMSMapID(identifier: Constants.mapId), camera: GMSCameraPosition.camera(withLatitude: 35.681111, longitude: 139.766667, zoom: 15.0) )
    var isAnimating: Bool = false
    
    override func loadView() {
        super.loadView()
        self.map.isMyLocationEnabled = true
        self.view = map
    }
}
