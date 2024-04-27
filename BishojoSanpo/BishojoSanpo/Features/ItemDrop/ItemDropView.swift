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
    @State private var canShowResult = false
    @State private var getItemImageData: Data? = nil
    
    var body: some View {
        ZStack{
            //背景が動くならここを書き換える
            WebPImageView(imageName: "Background.webp")
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .edgesIgnoringSafeArea(.all)
            if(canShowResult) {
                VStack {
                    ResultDetailBox(rank: rewardModel.rank!, untilNextRank: rewardModel.untilNextRank!)
                    Button(action: {
                        router.returnToHome()
                    }) {
                        WebPImageView(imageName: "Button_BackHome.webp").aspectRatio(contentMode: .fit).frame(width: UIScreen.main.bounds.width * 0.5)
                    }
                    Button(action: {
                        router.navigateToDressUp()
                    }) {
                        WebPImageView(imageName: "Button_ChangeWear.webp").aspectRatio(contentMode: .fit).frame(width: UIScreen.main.bounds.width * 0.5)
                    }
                }
            } else {
                VStack{
                    WebPImageView(imageName: "present_box.webp").aspectRatio(contentMode: .fit).frame(width: UIScreen.main.bounds.width * 0.8)
                    WebPImageView(imageName: "tap_to_open.webp").aspectRatio(contentMode: .fit).frame(width: UIScreen.main.bounds.width * 0.7)
                }
                DetectTapView(isTapped: $isTapped)
                VStack {
                    Button(action: {
                        showResult()
                    }) {
                        WebPImageView(imageName: "skip_button.webp").aspectRatio(contentMode: .fit)
                            .frame(width: 70)
                            .padding(.top, 15)
                            .padding(.trailing, 12)
                    }
                }.frame(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height,
                    alignment:
                        .topTrailing
                )
                    
                if let dropItemData = getItemImageData , isTapped {
                    ZStack {
                        WebPImageView(imageName: "effect.webp")
                        VStack {
                            Image(uiImage: UIImage(data: dropItemData)!).resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.main.bounds.width * 0.35)
                            Text(rewardModel.dropItem!.name).foregroundColor(.white).font(.system(size: 25)).fontWeight(.black).shadow(color: Color.black.opacity(0.9), radius: 8)
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
            }
        }
    }
    private func showResult() {
        canShowResult = true
    }
}

#Preview {
    let goalData = GoalData(placeId: "", currentLatitude: 22, currentLongtitude: 11, selectedDistance: "")
    return ItemDropView(goalData: goalData)
}
