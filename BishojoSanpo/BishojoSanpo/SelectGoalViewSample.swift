//
//  SelectGoalViewSample.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/13.
//


import SwiftUI
import CoreLocation

struct SelectGoalViewSample: View {

    @EnvironmentObject var router: NavigationRouter
    @State var sendToMapData: GoalData = GoalData()
    @State var hasUpdateLocation = false
    var selectGoalModel: SelectGoalModel = SelectGoalModel()
    var locationManager: LocationManager
    let directionModel = DirectionModel()

    var body: some View {
        VStack{
            Button(action: locationManager.fetchLocation, label: {Text("APIを叩いてMapViewへ")})
            Button(action: router.returnToHome, label: {Text("Home")})
        }
        // --- ※ onAppear, DisAppearが必要かどうかは要検証 ---
        .navigationBarBackButtonHidden(true)
        .onAppear {
            locationManager.onLocationUpdate = { newLocation in
                if !hasUpdateLocation {getDestinationAndNavigate(newLocation: newLocation)}
            }
        }
        .onDisappear {
                        locationManager.onLocationUpdate = nil
                    }

    }
    

    private func getDestinationAndNavigate(newLocation: CLLocation) {

        selectGoalModel.selectedCategory = "サウナ"// 選択されたカテゴリをこの変数に入れる
        selectGoalModel.selectedDistance = "far" // カテゴリと同様
        
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
    return SelectGoalViewSample(locationManager: locationManager)
}
