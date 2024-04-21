//
//  MapView.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/09.
//  MapView
//

import GoogleMaps
import SwiftUI


struct MapView: View {
    
    @ObservedObject var markerManager: MarkerManager
    @State var polyline: GMSPolyline?
    @State var isChangedPolyline = false
    @State var zoomInCenter: Bool = false
    var locationManager: LocationManager
    let goalData: GoalData
    let directionModel = DirectionModel()
    
    init(locationManager: LocationManager, goalData: GoalData) {
        self.locationManager = locationManager
        self.goalData = goalData
        self.markerManager = MarkerManager(coordinate: CLLocationCoordinate2D(latitude: goalData.destinationLatitude, longitude: goalData.destinationLongtitude))
    }
    
    var body: some View {
        
        ZStack{
            MapViewControllerBridge(polyline: $polyline,marker: $markerManager.destinationMarker, isChangedPolyline: $isChangedPolyline,goalData: goalData)
           
            WebPImageView(imageName: "HeartBase.webp")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .scaledToFill()
                .allowsHitTesting(false)
            WebPImageView(imageName: "HeartFrame.webp")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .scaledToFill()
                .allowsHitTesting(false)
            ArrivedButtonView(goalData: goalData)
            HomeButtonView()
            
        }.offset(y:-7)
        
        .onAppear{
            loadDirection()
        }
        .navigationBarBackButtonHidden(true)
    }
    func loadDirection() {
        let destination = "place_id:\(goalData.placeId)"
        let startLocation = "\(goalData.currentLatitude),\(goalData.currentLongtitude)"
        
        DispatchQueue.global(qos: .userInitiated).async {
            // 経路情報取得
            let directionResult = directionModel.getDirection(destination: destination, start: startLocation)
            // 取得した経路情報を用いてpolylineを作成
            if let directionResult = directionResult {
                DispatchQueue.main.async {
                    self.polyline = directionModel.createPolyline(from: directionResult)
                    isChangedPolyline = true // MapViewControllerBridgeに変更を検知させるためのフラグをtrueに
                }
            }
        }
    }
    
}


class MarkerManager: ObservableObject {
    @Published var destinationMarker: GMSMarker
    
    init(coordinate: CLLocationCoordinate2D) {
        self.destinationMarker = GMSMarker(position: coordinate)
    }
}

#Preview{
    let goalData = GoalData(placeId: "", currentLatitude: 22, currentLongtitude: 11, selectedDistance: "")
    let locationManager = LocationManager()
    return MapView(locationManager: locationManager, goalData: goalData)
}


