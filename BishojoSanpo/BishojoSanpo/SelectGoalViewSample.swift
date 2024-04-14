//
//  SelectGoalViewSample.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/13.
//


import SwiftUI

struct SelectGoalViewSample: View {
    // --- 以下の一行を追加 ---
    @EnvironmentObject var router: NavigationRouter
    @EnvironmentObject var goalViewModel: GoalViewModel
    // ----------------------
    var body: some View {
        VStack{
            // デバッグ用ボタン
            Button(action: {
                getDestinationAndNavigate()
            }, label: {
                Text("APIを叩いてMapViewへ")
            })
            Button(action: {
                router.items.removeLast(router.items.count) // Homeへ
                
            }, label: {
                Text("Home")
            })
            
        }
        .navigationBarBackButtonHidden(true)
    }
    func getDestinationAndNavigate(){
        goalViewModel.selectedCategory = "サウナ"// 選択されたカテゴリをこの変数に入れる
        goalViewModel.selectedDistance = "far" // カテゴリと同様
        Task {
            await goalViewModel.fetchSuggestedPlace()
            print("errorMessage: \(String(describing: goalViewModel.errorMessage))")
            print("placeId: \(goalViewModel.placeId)")
            print("latitude: \(goalViewModel.latitude)")
            print("longitude: \(goalViewModel.longitude)")
        }
        router.items.append(.map) //Map画面へ遷移
    }
    
}

#Preview {
    SelectGoalViewSample()
}
