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
    let directionModel = DirectionModel()
    let goalData: GoalData
    
    
    func makeUIViewController(context: Context) -> MapViewController {
        // Replace this line
        let uiViewController = MapViewController()
        uiViewController.map.delegate = context.coordinator
        return MapViewController()
    }
    
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        marker.map = uiViewController.map
        uiViewController.map.selectedMarker = marker // デフォルトでマーカーの場所名を表示させた状態にするための設定
        // アニメーションが未完了の場合のみアニメーションを実行
        if isChangedPolyline, let polyline = polyline {
            polyline.map = uiViewController.map
            updateCameraZoom(startLat: goalData.currentLatitude,
                             startLng: goalData.currentLongtitude,
                             endLat: goalData.destinationLatitude,
                             endLng: goalData.destinationLongtitude,
                             uiViewController: uiViewController)
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
    private func updateCameraZoom(startLat: Double, startLng: Double, endLat: Double, endLng: Double, uiViewController: MapViewController) {
        let startCoordinate = CLLocationCoordinate2D(latitude: startLat, longitude: startLng)
        let endCoordinate = CLLocationCoordinate2D(latitude: endLat, longitude: endLng)
        let bounds = GMSCoordinateBounds(coordinate: startCoordinate, coordinate: endCoordinate)
        let cameraUpdate = GMSCameraUpdate.fit(bounds, withPadding: 160.0)
        uiViewController.map.moveCamera(cameraUpdate)
    }
}
