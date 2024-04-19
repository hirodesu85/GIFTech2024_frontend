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
    @Binding var polyline:  GMSPolyline?
    @Binding var marker: GMSMarker
    @Binding var isChangedPolyline: Bool
    
    
    var onAnimationEnded: () -> ()
    let directionModel = DirectionModel()
    
    
    // アニメーションが完了したかどうかを追跡する状態
    @State private var isAnimationCompleted = false
    
    func makeUIViewController(context: Context) -> MapViewController {
        // Replace this line
        let uiViewController = MapViewController()
        uiViewController.map.delegate = context.coordinator
        return MapViewController()
    }
    
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        marker.map = uiViewController.map
        // アニメーションが未完了の場合のみアニメーションを実行
        if !isAnimationCompleted {
            animateToSelectedMarker(viewController: uiViewController)
            
        }
        if isChangedPolyline, let polyline = polyline {
                polyline.map = uiViewController.map
                print("Polyline is changed and added to the map.")
            }
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
                            self.isAnimationCompleted = true
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
