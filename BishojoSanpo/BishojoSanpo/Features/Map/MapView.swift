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
    let goalData: GoalData
    let destination = City(name: "Tokyo", coordinate: CLLocationCoordinate2D(latitude: 35.6684411, longitude: 139.6004407))
    
    /// State for markers displayed on the map for each city in `cities`
    @State var destinationMarker: GMSMarker
    @State var zoomInCenter: Bool = false
    
    init(goalData: GoalData) {
        self.goalData = goalData
        print(goalData.placeId)
        self.destinationMarker = GMSMarker(position: destination.coordinate)
        destinationMarker.title = destination.name
    }
    
    var body: some View {
        
        let scrollViewHeight: CGFloat = 80
        
        GeometryReader { geometry in
            ZStack{
                VStack{
                    Text(goalData.placeId)
                    Spacer()
                    HStack{
                        Spacer()
                        MapContainerView(zoomInCenter: $zoomInCenter, marker: $destinationMarker)
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
        .navigationBarBackButtonHidden(true)
    }
}


struct MapContainerView: View {
    
    @Binding var zoomInCenter: Bool
    @Binding var marker: GMSMarker
    
    var body: some View {
        GeometryReader { geometry in
            let diameter = zoomInCenter ? geometry.size.width : (geometry.size.height * 2)
            MapViewControllerBridge(marker: $marker,onAnimationEnded: {
                      self.zoomInCenter = true
            })
                
        }
    }
}

#Preview{
    let goalData = GoalData(placeId: "", latitude: 22, longtitude: 11, selectedDistance: "")
    return MapView(goalData: goalData)
}
