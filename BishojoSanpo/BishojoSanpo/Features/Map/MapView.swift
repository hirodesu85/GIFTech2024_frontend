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
    var locationManager: LocationManager
    let goalData: GoalData
    @State var polyline: GMSPolyline?
    @State var isChangedPolyline = false
    
    @State var zoomInCenter: Bool = false
    let directionModel = DirectionModel()
    @ObservedObject var markerManager: MarkerManager
    
    init(locationManager: LocationManager, goalData: GoalData) {
        self.locationManager = locationManager
        self.goalData = goalData
        self.markerManager = MarkerManager(coordinate: CLLocationCoordinate2D(latitude: goalData.destinationLatitude, longitude: goalData.destinationLongtitude))
        
    }
    
    var body: some View {
        
        let scrollViewHeight: CGFloat = 80
        
        GeometryReader { geometry in
            ZStack{
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        MapContainerView(polyline: $polyline, zoomInCenter: $zoomInCenter, marker: $markerManager.destinationMarker, isChangedPolyline: $isChangedPolyline)
                            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.9, alignment: .center)
                        Spacer()
                    }
                    Button(action: {
                        router.items.append(.itemDrop)
                    }, label: {
                        Text("到着")
                    })
                    Spacer()
                }
                
            }
        }
        .onAppear{
            loadDirection()
        }
        .navigationBarBackButtonHidden(true)
        
    }
    func loadDirection() {
        let destination = "place_id:\(goalData.placeId)"
        let startLocation = "\(goalData.currentLatitude),\(goalData.currentLongtitude)"
        
        // 前述した同期関数を使用してDirectionを取得
        DispatchQueue.global(qos: .userInitiated).async {
            let directionResult = directionModel.getDirection(destination: destination, start: startLocation)
            if let directionResult = directionResult {
                DispatchQueue.main.async {
                    self.polyline = directionModel.createPolyline(from: directionResult)
                    isChangedPolyline = true
                }
            } else {
                // directionResult が nil の場合のエラーハンドリング
                print("DirectionAPI失敗")
            }

        }
    }
}


struct MapContainerView: View {
    
    @Binding var polyline: GMSPolyline?
    @Binding var zoomInCenter: Bool
    @Binding var marker: GMSMarker
    @Binding var isChangedPolyline: Bool
    
    var body: some View {
        GeometryReader { geometry in
            let diameter = zoomInCenter ? geometry.size.width : (geometry.size.height * 2)
            MapViewControllerBridge(polyline: $polyline,marker: $marker, isChangedPolyline: $isChangedPolyline,onAnimationEnded: {
                self.zoomInCenter = true
            })
            
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


