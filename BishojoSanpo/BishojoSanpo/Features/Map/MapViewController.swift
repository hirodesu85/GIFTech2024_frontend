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

  let map =  GMSMapView(frame: .zero)
  var isAnimating: Bool = false

  override func loadView() {
    super.loadView()
    self.view = map
  }
}
