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
    @EnvironmentObject var router: NavigationRouter
    @ObservedObject var markerManager: MarkerManager
    @State var polyline: GMSPolyline?
    @State var isChangedPolyline = false
    @State var zoomInCenter: Bool = false
    let goalData: GoalData
    let directionModel = DirectionModel()
    
    init(goalData: GoalData) {
        self.goalData = goalData
        self.markerManager = MarkerManager(coordinate: CLLocationCoordinate2D(latitude: goalData.destinationLatitude, longitude: goalData.destinationLongtitude), placeName: goalData.placeName, placeImageUrl: goalData.placeImageUrl)
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
            
        }
        .ignoresSafeArea()
        
        .onAppear{
            loadDirection()
            BgmPlayer.shared.playBackgroundMusic(filename: "bgm_map")
        }
        .navigationBarBackButtonHidden(true)
    }
    func loadDirection() {
        let destination = "place_id:\(goalData.placeId)"
        let startLocation = "\(goalData.currentLatitude),\(goalData.currentLongtitude)"
        
        DispatchQueue.global(qos: .userInitiated).async {
            // 経路情報取得
            let directionResult = directionModel.getDirection(destination: destination, start: startLocation, selectedDistance: goalData.selectedDistance)
            // 取得した経路情報を用いてpolylineを作成
            if let directionResult = directionResult {
                DispatchQueue.main.async {
                    self.polyline = directionModel.createPolyline(from: directionResult)
                    let endAddress = directionResult.routes.last?.legs.last?.endAddress.replacingOccurrences(of: "日本、", with: "") ?? ""
                    let distanceText = directionResult.routes.last?.legs.last?.distance.text ?? ""
                    self.markerManager.destinationMarker.snippet = "\(endAddress)\n移動距離: \(distanceText)"
                    isChangedPolyline = true // MapViewControllerBridgeに変更を検知させるためのフラグをtrueに
                }
            }
        }
    }
    
}


class MarkerManager: ObservableObject {
    @Published var destinationMarker: GMSMarker
    
    init(coordinate: CLLocationCoordinate2D, placeName: String, placeImageUrl: String) {
        self.destinationMarker = GMSMarker(position: coordinate)
        self.destinationMarker.title = placeName
        self.destinationMarker.userData = placeImageUrl
    }
}

#Preview{
    let goalData = GoalData(placeId: "", currentLatitude: 22, currentLongtitude: 11, selectedDistance: "")
    return MapView(goalData: goalData)
}
