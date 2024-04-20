//
//  SelectGoalView.swift
//  BishojoSanpo
//
//  Created by 尾形拓夢 on 2024/04/12.
//

import SwiftUI
import CoreLocation

struct SelectGoalView: View {
    
    @EnvironmentObject var router: NavigationRouter
    @State var sendToMapData: GoalData = GoalData()
    @State var hasUpdateLocation = false
    var selectGoalModel: SelectGoalModel = SelectGoalModel()
    var locationManager: LocationManager
    let directionModel = DirectionModel()
    
    @State var isSelectedCategory: Bool = false
    @State var selectedCategory: Int = -1
    @State var isSelectedDistance: Bool = false
    @State var selectedDistance: Int = -1
    
    let categoryOptions = ["散歩", "サウナ", "ご飯"]
    let distanceOptions = ["近く", "中距離", "遠く"]
    let distanceOptionsData = ["near", "middle", "far"]
    
    var body: some View {
        ZStack {
            WebPImageView(imageName: "Background.webp")
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .edgesIgnoringSafeArea(.all)

            ZStack(alignment: .top) {
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack {
                            Color.clear
                                .frame(height: 80)
                            
                            GirlChatView(girlText: "wwwwwww")
                            
                            MyChatView(isSelected: $isSelectedCategory,
                                       selectedOption: $selectedCategory,
                                       options: categoryOptions)
                            if isSelectedCategory {
                                GirlChatView(girlText: "wwwwwwwwwww")
                                
                                MyChatView(isSelected: $isSelectedDistance,
                                           selectedOption: $selectedDistance,
                                           options: distanceOptions)
                                
                                Color.clear.id(1)
                                    .frame(height: 80)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .onChange(of: isSelectedCategory) { _ in
                        withAnimation {
                            proxy.scrollTo(1)
                        }
                    }
                }
                HeaderView()
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            locationManager.onLocationUpdate = { newLocation in
                if !hasUpdateLocation {getDestinationAndNavigate(newLocation: newLocation)}
            }
        }
        .onDisappear {
            locationManager.onLocationUpdate = nil
        }
        .onChange(of: isSelectedDistance) { _ in
            locationManager.fetchLocation()
        }
    }
    
    private func getDestinationAndNavigate(newLocation: CLLocation) {
        
        selectGoalModel.selectedCategory = categoryOptions[selectedCategory]
        selectGoalModel.selectedDistance = distanceOptionsData[selectedDistance]
        
        hasUpdateLocation = true
        selectGoalModel.currentLatitude = newLocation.coordinate.latitude // 位置情報を更新
        selectGoalModel.currentLongitude = newLocation.coordinate.longitude
        
        Task {
            await selectGoalModel.fetchSuggestedPlace()  // API呼び出しと内部状態の更新
            sendToMapData.update(from: selectGoalModel) // GoalDataにSelectGoalModelのデータを反映
            router.navigateToMap(with: sendToMapData) // 更新されたGoalDataを持ってナビゲーション
        }
    }

}

#Preview {
    let locationManager = LocationManager()
    return SelectGoalView(locationManager: locationManager).environmentObject(NavigationRouter())
}
