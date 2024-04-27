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
    var locationManager = LocationManager()
    let directionModel = DirectionModel()
    
    @State var isSelectedCategory: Bool = false
    @State var selectedCategory: Int = -1
    @State var isSelectedDistance: Bool = false
    @State var selectedDistance: Int = -1
    @State var isSelectedSelectAgain: Bool = false
    @State var selectedSelectAgain: Int = -1
    @State private var isError: Bool = false
    @State private var isLoading: Bool = false
    
    let categoryOptions = ["散歩", "サウナ", "ご飯"]
    let distanceOptions = ["近く", "中距離", "遠く"]
    let distanceOptionsData = ["near", "middle", "far"]
    let selectAgainOptions = ["了解🫡"]
    
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
                            
                            GirlChatView(girlText: "どこに行く？")
                            
                            MyChatView(isSelected: $isSelectedCategory,
                                       selectedOption: $selectedCategory,
                                       options: categoryOptions)
                            if isSelectedCategory {
                                GirlChatView(girlText: "どこまで行く？")
                                
                                MyChatView(isSelected: $isSelectedDistance,
                                           selectedOption: $selectedDistance,
                                           options: distanceOptions)
                                
                                Color.clear.id(1)
                                    .frame(height: 50)
                            }
                            if isLoading {
                                GirlChatView(girlText: "どこにしようかな〜")
                                
                                Color.clear.id(2)
                                    .frame(height: 100)
                            }
                            if isError {
                                GirlChatView(girlText: "場所が見つからなかった...😭")
                                GirlChatView(girlText: "もう一度選択してくれる？🥺")
                                MyChatView(isSelected: $isSelectedSelectAgain,
                                           selectedOption: $selectedSelectAgain,
                                           options: selectAgainOptions)

                                Color.clear.id(3)
                                    .frame(height: 120)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .onChange(of: isSelectedCategory) { _ in
                        withAnimation {
                            proxy.scrollTo(1)
                        }
                    }
                    .onChange(of: isLoading) { _ in
                        withAnimation {
                            proxy.scrollTo(2)
                        }
                    }
                    .onChange(of: selectGoalModel.errorMessage) { _ in
                        withAnimation {
                            proxy.scrollTo(3)
                        }
                    }
                }
                HeaderView()
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            locationManager.onLocationUpdate = { newLocation in
                if !hasUpdateLocation && isSelectedCategory {getDestinationAndNavigate(newLocation: newLocation)}
            }
            BgmPlayer.shared.playBackgroundMusic(filename: "bgm_selectGoal")
        }
        .onChange(of: isSelectedDistance) { _ in
            locationManager.fetchLocation()
        }
        .onChange(of: isSelectedSelectAgain) { _ in
            if isSelectedSelectAgain {
                isSelectedCategory = false
                isSelectedDistance = false
                isLoading = false
                isError = false
                selectGoalModel.errorMessage = nil
                isSelectedSelectAgain = false
                hasUpdateLocation = false
            }
        }
    }
    
    private func getDestinationAndNavigate(newLocation: CLLocation) {
        selectGoalModel.selectedCategory = categoryOptions[selectedCategory]
        selectGoalModel.selectedDistance = distanceOptionsData[selectedDistance]
        
        hasUpdateLocation = true
        selectGoalModel.currentLatitude = newLocation.coordinate.latitude // 位置情報を更新
        selectGoalModel.currentLongitude = newLocation.coordinate.longitude
        
        Task {
            isLoading = true
            await selectGoalModel.fetchSuggestedPlace()  // API呼び出しと内部状態の更新
            sendToMapData.update(from: selectGoalModel) // GoalDataにSelectGoalModelのデータを反映
            if selectGoalModel.errorMessage == nil {
                router.navigateToMap(with: sendToMapData) // 更新されたGoalDataを持ってナビゲーション
            } else {
                isError = true
            }
        }
    }

}

#Preview {
    let locationManager = LocationManager()
    return SelectGoalView(locationManager: locationManager).environmentObject(NavigationRouter())
}
