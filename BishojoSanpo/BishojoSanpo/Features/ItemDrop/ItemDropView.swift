//
//  ItemDropView.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/13.
//

import SwiftUI

struct ItemDropView: View {
    @EnvironmentObject var router: NavigationRouter
    let goalData: GoalData
    @StateObject private var rewardModel = RewardModel()
    @State private var isTapped = false
    
    var body: some View {
        ZStack{
            VStack{
                Text("プレゼントの画像を表示")
                Text("Tap Open!")
                if let dropItem = rewardModel.dropItem{
                    Text("アイテム獲得！")
                    Text(dropItem.name)
                }else{
                    Text("アイテムをロード中")
                }
            }
            DetectTapView(isTapped: $isTapped)
                
            HomeButtonView()
                
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .onAppear{
            Task {
                await rewardModel.fetchRewardData(goalData: goalData)
            }
            BgmPlayer.shared.playBackgroundMusic(filename: "bgm_selectGoal")
        }
        
        
    }
}

#Preview {
    let goalData = GoalData(placeId: "", currentLatitude: 22, currentLongtitude: 11, selectedDistance: "")
    return ItemDropView(goalData: goalData)
}
