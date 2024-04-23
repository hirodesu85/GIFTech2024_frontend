//
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/04.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var router = NavigationRouter()
    @StateObject var locationManager = LocationManager()
    @ObservedObject var userDefaultsModel = UserDefaultsModel()  // @StateObject から @ObservedObject へ変更可能
    let bishojoViewWidth: Double = 350
    
    init(){
        UserDefaults.standard.register(defaults: ["rank": 7])
    }
    
    var body: some View {
        NavigationStack(path: $router.items){
            ZStack {
                VStack {
                    HStack() {
                        Spacer(minLength: 20)
                        RankView(rank: userDefaultsModel.rank)
                            .frame(width: 135)
                        RankPointBarView(nowRankPoint: userDefaultsModel.currentRankPoint,nextRankPoint: userDefaultsModel.untilNextRank)
                            .offset(y:-18)
                        Spacer(minLength: 20)
                    }
                    Spacer()
                }
                BishojoView()
                    .position(x:170,y:400)
                    .scaleEffect(1.7)
                    .onTapGesture {
                        print("Tapped")
                    }
                DressUpButton()
                SelectGoalButton()
                // デバッグボタン
                VStack{
                    Button {
                        // 数値を変える処理
                        userDefaultsModel.updateCurrentRankPoint(newCurrentRankPoint: userDefaultsModel.currentRankPoint + 10)
                        userDefaultsModel.updateUntilNextRank(newUntilNextRank: userDefaultsModel.untilNextRank - 10)
                    } label: {
                        Text("ポイントが10増える")
                    }
                    Button(action: {
                        userDefaultsModel.updateCurrentRankPoint(newCurrentRankPoint: 0)
                        userDefaultsModel.updateUntilNextRank(newUntilNextRank: 100)
                    }, label: {
                        Text("ポイントをリセット")
                    })
                }
                

            }
            // 画面遷移定義
            .navigationDestination(for: NavigationRouter.Item.self) { item in
                switch item {
                case .selectGoal:
                    SelectGoalView(locationManager: locationManager)
                        .environment(\.font, .custom("NotoSansJP-Black", size: 25))
                case .map(let goalData):
                    MapView(locationManager: locationManager, goalData: goalData)
                case .itemDrop(let goalData):
                    ItemDropView(goalData: goalData)
                case .dressUp:
                    DressUpView()
                }
            }
        }
        .environmentObject(router)
    }
    
    
}

#Preview {
    HomeView()
}
