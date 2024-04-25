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
            //背景が動くならここを書き換える
            WebPImageView(imageName: "Background.webp")
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .edgesIgnoringSafeArea(.all)
            VStack{
                WebPImageView(imageName: "present_box.webp").aspectRatio(contentMode: .fit).frame(width: UIScreen.main.bounds.width * 0.8)
                WebPImageView(imageName: "tap_to_open.webp").aspectRatio(contentMode: .fit).frame(width: UIScreen.main.bounds.width * 0.7)
                /*
                Text("プレゼントの画像を表示")
                Text("Tap Open!")
                if let dropItem = rewardModel.dropItem{
                    Text("アイテム獲得！")
                    Text(dropItem.name)
                }else{
                    Text("アイテムをロード中")
                }*/
            }
            DetectTapView(isTapped: $isTapped)
            VStack {
                Button(action: {
                    router.returnToHome()
                }) {
                    WebPImageView(imageName: "skip_button.webp").aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                        .padding(.top, 15)
                        .padding(.trailing, 12)
                }
            }.frame(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height,
                alignment: 
                    .topTrailing
            )
                
            if let dropItem = rewardModel.dropItem , isTapped {
                AsyncImage(url: URL(string: dropItem.imageUrl)) { phase in
                    if let dropItemImage = phase.image {
                        ZStack {
                            WebPImageView(imageName: "effect.webp")
                            dropItemImage.resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    } else if phase.error != nil {
                        Text("画像読み込みエラー")
                    } else {
                        Text("ロード中")
                    }
                }
            }
                
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .onAppear{
            Task {
                await rewardModel.fetchRewardData(goalData: goalData)
            }
        }
        
        
    }
}

#Preview {
    let goalData = GoalData(placeId: "", currentLatitude: 22, currentLongtitude: 11, selectedDistance: "")
    return ItemDropView(goalData: goalData)
}
