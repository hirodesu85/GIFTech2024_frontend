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
        self.map.delegate = self
        self.view = map
    }
}

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        guard let imageUrlString = marker.userData as? String, let imageUrl = URL(string: imageUrlString) else {
            return nil
        }

        let infoWindowView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 110))
        infoWindowView.backgroundColor = .white
        infoWindowView.layer.cornerRadius = 5.0

        let titleLabel = UILabel(frame: CGRect(x: 110, y: 5, width: 135, height: 0))
        titleLabel.text = marker.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        infoWindowView.addSubview(titleLabel)

        let snippetLabel = UILabel(frame: CGRect(x: 110, y: titleLabel.frame.maxY + 5, width: 135, height: 0))
        snippetLabel.text = marker.snippet
        snippetLabel.font = UIFont.systemFont(ofSize: 12)
        snippetLabel.textColor = UIColor.gray
        snippetLabel.numberOfLines = 0
        snippetLabel.sizeToFit()
        infoWindowView.addSubview(snippetLabel)

        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 100, height: snippetLabel.frame.maxY))
        imageView.contentMode = .scaleAspectFill // アスペクト比を保持
        imageView.clipsToBounds = true // 余白切り捨て
        imageView.layer.cornerRadius = 5.0
        loadImage(from: imageUrl) { image in
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
        infoWindowView.addSubview(imageView)

        // 情報ウィンドウの高さを調整
        infoWindowView.frame.size.height = imageView.frame.maxY + 5

        return infoWindowView
    }

    private func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                completion(nil)
                return
            }

            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
}
