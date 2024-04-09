//
//  MapViewControllerBridge.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/09.
// UIKitで動くMapViewControllerをSwiftUIのMapView内に埋め込むコード
//

import GoogleMaps
import SwiftUI

struct MapViewControllerBridge: UIViewControllerRepresentable {
    @Binding var marker: GMSMarker
    var onAnimationEnded: () -> ()
    
    func makeUIViewController(context: Context) -> MapViewController {
        // Replace this line
        let uiViewController = MapViewController()
        uiViewController.map.delegate = context.coordinator
        return MapViewController()
    }
    
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        marker.map = uiViewController.map
        animateToSelectedMarker(viewController: uiViewController)
    }
    private func animateToSelectedMarker(viewController: MapViewController) {
        let map = viewController.map
        if map.selectedMarker != marker {
            map.selectedMarker = marker
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                map.animate(toZoom: kGMSMinZoomLevel) //ZoomLevel 2~21
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    map.animate(with: GMSCameraUpdate.setTarget(marker.position))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        map.animate(toZoom: 12)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                            // Invoke onAnimationEnded() once the animation sequence completes
                            onAnimationEnded()
                        })
                    })
                }
            }
            
        }
    }
    final class MapViewCoordinator: NSObject, GMSMapViewDelegate {
        var mapViewControllerBridge: MapViewControllerBridge
        
        init(_ mapViewControllerBridge: MapViewControllerBridge) {
            self.mapViewControllerBridge = mapViewControllerBridge
        }
    }
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator(self)
    }
}
