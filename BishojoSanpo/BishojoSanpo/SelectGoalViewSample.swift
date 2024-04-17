//
//  SelectGoalViewSample.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/13.
//


import SwiftUI
import CoreLocation

struct SelectGoalViewSample: View {
    // --- 以下の一行を追加 ---
    @EnvironmentObject var router: NavigationRouter
    var selectGoalModel: SelectGoalModel = SelectGoalModel()
    @State var sendToMapData: GoalData = GoalData()
    var locationManager: LocationManager
    @State var hasUpdateLocation = false
    let directionModel = DirectionModel()
    
    // ----------------------
    var body: some View {
        VStack{
            // デバッグ用ボタン
            Button(action: locationManager.fetchLocation, label: {Text("APIを叩いてMapViewへ")})
            Button(action: router.returnToHome, label: {Text("Home")})
//            Button (action:test,label: {Text("位置情報取得")})
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
    }
    
    private func getDestinationAndNavigate(newLocation: CLLocation) {
        hasUpdateLocation = true
        // 位置情報を更新
        selectGoalModel.currentLatitude = newLocation.coordinate.latitude
        selectGoalModel.currentLongitude = newLocation.coordinate.longitude
        
        selectGoalModel.selectedCategory = "サウナ"// 選択されたカテゴリをこの変数に入れる
        selectGoalModel.selectedDistance = "far" // カテゴリと同様
        Task {
            await selectGoalModel.fetchSuggestedPlace()  // API呼び出しと内部状態の更新
            
            // GoalDataにSelectGoalModelのデータを反映
            sendToMapData.update(from: selectGoalModel)
            // 更新されたGoalDataを持ってナビゲーション
            router.navigateToMap(with: sendToMapData)
        }
    }
    
}

#Preview {
    let locationManager = LocationManager()
    return SelectGoalViewSample(locationManager: locationManager)
}
