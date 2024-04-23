//
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/04.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var router = NavigationRouter()
    @StateObject var locationManager = LocationManager()
    @ObservedObject var userDefaultsModel = UserDefaultsModel()
    @State var isSerifShowed: Bool =  false
    @State var reloadSerif: Bool = false
    let bishojoViewWidth: Double = 350
    
    
    var body: some View {
        NavigationStack(path: $router.items){
            ZStack {
                // ランク表示
                VStack {
                    HStack() {
                        Spacer(minLength: 20)
                        RankView(userDefaultsModel: userDefaultsModel)
                            .frame(width: 135)
                        RankPointBarView(nowRankPoint: userDefaultsModel.currentRankPoint, nextRankPoint: userDefaultsModel.untilNextRank)
                            .offset(y:-18)
                        Spacer(minLength: 20)
                    }
                    Spacer()
                }
                
                BishojoView()
                    .position(x:170,y:400)
                    .scaleEffect(1.7)
                    .onTapGesture {
                        if isSerifShowed {
                            reloadSerif.toggle()
                        } else {
                            isSerifShowed = true
                        }
                    }
                if isSerifShowed {
                    SerifView(reload: reloadSerif)
                        .position(x:300,y:215)
                        .scaleEffect(0.6)
                }
                DressUpButton()
                SelectGoalButton()
                
                // デモボタン ItemDropViewで値を更新できたら消す
                VStack{
                    Button {
                        userDefaultsModel.updateCurrentRankPoint(newCurrentRankPoint: userDefaultsModel.currentRankPoint + 100)
                        userDefaultsModel.updateUntilNextRank(newUntilNextRank: userDefaultsModel.untilNextRank - 100)
                        userDefaultsModel.updateRank(newRank: 8)
                    } label: {
                        Text("ポイントが100増える").background(Color.white)
                    }
                    Button(action: {
                        userDefaultsModel.updateCurrentRankPoint(newCurrentRankPoint: 0)
                        userDefaultsModel.updateUntilNextRank(newUntilNextRank: 700)
                        userDefaultsModel.updateRank(newRank: 7)
                    }, label: {
                        Text("ポイントをリセット").background(Color.white)
                    })
                }
                // デモボタンここまで
                
                
            }
            .onChange(of: router.items) { newValue in
                if newValue.contains(where: { $0 == .selectGoal || $0 == .dressUp }) {
                    isSerifShowed = false
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
