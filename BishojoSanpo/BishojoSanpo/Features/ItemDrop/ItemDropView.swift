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
    @ObservedObject var userDefaultsModel = UserDefaultsModel.shared
    @State private var isTapped = false
    @State private var canShowResult = false
    @State private var getItemImageData: Data? = nil
    @State private var isPressedHome = false
    @State private var isPressedDressUp = false
    
    var body: some View {
        ZStack{
            //背景が動くならここを書き換える
            WebPImageView(imageName: "Background.webp")
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .edgesIgnoringSafeArea(.all)
            if(canShowResult) {
                VStack {
                    ResultDetailBox(userDefaultsModel: userDefaultsModel).frame(width: 340).offset(y:-20)
                    Button(action: {
                        AudioPlayer.shared.playSound()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            router.returnToHome()
                        }
                    }) {
                        WebPImageView(imageName: "Button_BackHome.webp")
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width * 0.5)
                            .scaleEffect(isPressedHome ? 1.2 : 1)
                            .animation(.easeInOut(duration: 0.2), value: isPressedHome)
                    }
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in isPressedHome = true }
                            .onEnded { _ in isPressedHome = false }
                    )
                    
                    Button(action: {
                        AudioPlayer.shared.playSound()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            router.navigateToDressUp()
                        }
                        
                    }) {
                        WebPImageView(imageName: "Button_ChangeWear.webp")
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width * 0.5)
                            .scaleEffect(isPressedDressUp ? 1.2 : 1)
                            .animation(.easeInOut(duration: 0.2), value: isPressedDressUp)
                    }
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in isPressedDressUp = true }
                            .onEnded { _ in isPressedDressUp = false }
                    )
                }
            } else {
                VStack{
                    WebPImageView(imageName: "present_box.webp").aspectRatio(contentMode: .fit).frame(width: UIScreen.main.bounds.width * 0.7).offset(y:-50)
                    WebPImageView(imageName: "tap_to_open.webp").aspectRatio(contentMode: .fit).frame(width: UIScreen.main.bounds.width * 0.7).offset(y:-50)
                }
                DetectTapView(isTapped: $isTapped)
                VStack {
                    Button(action: {
                        showResult()
                    }) {
                        WebPImageView(imageName: "skip_button.webp").aspectRatio(contentMode: .fit)
                            .frame(width: 50)
                            .padding(.top, 25)
                            .padding(.trailing, 14)
                    }
                }.frame(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height,
                    alignment:
                            .topTrailing
                )
                
                if let dropItemData = getItemImageData , isTapped {
                    ZStack {
                        WebPImageView(imageName: "effect.webp").offset(y:-40)
                        VStack {
                            Image(uiImage: UIImage(data: dropItemData)!).resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.main.bounds.width * 0.38)
                                .offset(y:-90)
                            Text(rewardModel.dropItem!.name).foregroundColor(.white).font(.system(size: 25)).fontWeight(.black).shadow(color: Color.black.opacity(0.9), radius: 8)
                                .offset(y:-50)
                        }
                    }.onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                            showResult()
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .onAppear{
            Task {
                await rewardModel.fetchRewardData(goalData: goalData)
                do {
                    guard let url = URL(string: rewardModel.dropItem!.imageUrl) else {
                        print("Invalid URL")
                        return
                    }
                    (getItemImageData, _) = try await URLSession.shared.data(from: url)
                } catch let err {
                    print("Error : \(err.localizedDescription)")
                }
                if (userDefaultsModel.untilNextRank > rewardModel.getRankPoint!) {
                    userDefaultsModel.updateUntilNextRank(newUntilNextRank: userDefaultsModel.untilNextRank - rewardModel.getRankPoint!)
                    userDefaultsModel.updateCurrentRankPoint(newCurrentRankPoint: userDefaultsModel.currentRankPoint + rewardModel.getRankPoint!)
                } else {
                    let nextRank = userDefaultsModel.rank + 1
                    let afterUntilNextRank = requireMaxRankPoint(rank: nextRank) - (rewardModel.getRankPoint! - userDefaultsModel.untilNextRank)
                    userDefaultsModel.updateRank(newRank: nextRank)
                    userDefaultsModel.updateUntilNextRank(newUntilNextRank: afterUntilNextRank)
                    userDefaultsModel.updateCurrentRankPoint(newCurrentRankPoint: requireMaxRankPoint(rank: nextRank) - afterUntilNextRank)
                }
            }
            BgmPlayer.shared.playBackgroundMusic(filename: "bgm_selectGoal")
        }
    }
    private func showResult() {
        canShowResult = true
    }
    
    // 今のランクからランクアップするのに必要な最大のポイントを返す
    private func requireMaxRankPoint(rank: Int) -> Int {
        switch rank {
        case 1:
            return 100
        case 2:
            return 200
        case 3:
            return 300
        case 4:
            return 400
        case 5:
            return 500
        case 6:
            return 600
        case 7:
            return 700
        case 8:
            return 800
        case 9:
            return 900
        default:
            return 1000
        }
        
    }
    // 前回のランクのMAXまでの通算ポイントを除いた現在のポイントを返す
    // 実際は7 ~ 8しか使われないが、それ以外も実装した(特に理由はない)
    private func calcNowRankPoint(rank: Int, untilNextRank: Int) -> Int {
        switch rank {
        case 1:
            return 100 - untilNextRank
        case 2:
            return 200 - untilNextRank
        case 3:
            return 300 - untilNextRank
        case 4:
            return 400 - untilNextRank
        case 5:
            return 500 - untilNextRank
        case 6:
            return 600 - untilNextRank
        case 7:
            return 700 - untilNextRank
        case 8:
            return 800 - untilNextRank
        case 9:
            return 900 - untilNextRank
        default:
            // ここが実行されることはあり得ないが、XCodeに怒られるし、例外を考えるのは面倒臭いのでデカい値を返す
            return 10000
        }
    }
}

#Preview {
    let goalData = GoalData(placeId: "", currentLatitude: 22, currentLongtitude: 11, selectedDistance: "")
    return ItemDropView(goalData: goalData)
}
