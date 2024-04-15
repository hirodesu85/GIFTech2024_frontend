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
    var selectGoalModel: SelectGoalModel = SelectGoalModel()
    @State var sendToMapData: GoalData = GoalData()
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
                router.returnToHome() // 変更点
                
            }, label: {
                Text("Home")
            })
        }
        .navigationBarBackButtonHidden(true)
    }
    private func getDestinationAndNavigate() {
        // ここでSelectGoalModelのプロパティが設定されます。
        goalViewModel.selectedCategory = "サウナ"// 選択されたカテゴリをこの変数に入れる
                goalViewModel.selectedDistance = "far" // カテゴリと同様
        Task {
            await goalViewModel.fetchSuggestedPlace()  // API呼び出しと内部状態の更新
            // GoalDataにSelectGoalModelのデータを反映
            sendToMapData.update(from: goalViewModel)
            // 更新されたGoalDataを持ってナビゲーション
            router.navigateToMap(with: sendToMapData)
        }
    }
    
}

#Preview {
    SelectGoalViewSample()
}
