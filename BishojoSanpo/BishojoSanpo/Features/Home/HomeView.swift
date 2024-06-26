//
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/04.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var router = NavigationRouter()
    @StateObject var locationManager = LocationManager()
    @ObservedObject var userDefaultsModel = UserDefaultsModel.shared
    @State var isSerifShowed: Bool =  false
    @State var reloadSerif: Bool = false
    @State var isPressedSelectGoal = false
    @State var isPressedDressUp = false
    
    
    var body: some View {
        NavigationStack(path: $router.items){
            ZStack {
                GeometryReader {geometry in

                    WebPImageView(imageName: "Background.webp")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .onTapGesture {
                            if isSerifShowed {
                                isSerifShowed = false
                            }
                        }

                    CharacterView(userDefaultsModel: userDefaultsModel)
                        .frame(width: 300)
                        .position(x: geometry.size.width * 0.4,y:geometry.size.height * 0.58)
                        .onTapGesture {
                            if isSerifShowed {

                                withAnimation(.linear(duration: 0.2)) {
                                    isSerifShowed = false
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    withAnimation(.linear(duration: 0.2)) {
                                        isSerifShowed = true
                                    }
                                }
                                reloadSerif.toggle()
                            } else {
                                isSerifShowed = true
                            }
                        }

                        HStack() {
                            Spacer(minLength: 20)
                            RankView(rank: userDefaultsModel.rank)
                                .frame(width: 135)
                            HomeRankPointView(nowRankPoint: userDefaultsModel.currentRankPoint, nextRankPoint: userDefaultsModel.untilNextRank)
                                .offset(y:-18)
                            Spacer(minLength: 20)
                        }
                        .position(x:geometry.size.width/2, y:geometry.size.height*0.12)
                    

                    if isSerifShowed {
                        SerifView(reload: reloadSerif, rank: userDefaultsModel.rank)
                            .position(x:geometry.size.width * 0.73,y:geometry.size.height * 0.3)
                            .scaleEffect(0.6)
                    }

                    DressUpButton(isPressed: $isPressedDressUp)
                        .frame(width: 150)
                        .position(x: geometry.size.width * 0.78, y: geometry.size.height * 0.9) // ボタンの位置を右下に設定
                    SelectGoalButton(isPressed: $isPressedSelectGoal)
                        .frame(width: 200)
                        .position(x: geometry.size.width * 0.74, y: geometry.size.height * 0.73) //
                }.ignoresSafeArea()
            }
            .onAppear {
                BgmPlayer.shared.playBackgroundMusic(filename: "bgm_home")
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
                    SelectGoalView()
                        .environment(\.font, .custom("NotoSansJP-Black", size: 20))
                case .map(let goalData):
                    MapView(goalData: goalData)
                case .itemDrop(let goalData):
                    ItemDropView(goalData: goalData)
                case .dressUp:
                    DressUpView(userDefaultsModel: userDefaultsModel)
                }
            }
        }
        .environmentObject(router)
    }
    
    
}

#Preview {
    HomeView()
}
	
