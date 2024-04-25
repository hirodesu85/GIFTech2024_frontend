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
    @State private var getItemImageData: Data? = nil
    
    var body: some View {
        ZStack{
            //背景が動くならここを書き換える
            WebPImageView(imageName: "Background.webp")
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .edgesIgnoringSafeArea(.all)
            VStack{
                WebPImageView(imageName: "present_box.webp").aspectRatio(contentMode: .fit).frame(width: UIScreen.main.bounds.width * 0.8)
                WebPImageView(imageName: "tap_to_open.webp").aspectRatio(contentMode: .fit).frame(width: UIScreen.main.bounds.width * 0.7)
            }
            DetectTapView(isTapped: $isTapped)
            VStack {
                Button(action: {
                    router.returnToHome()
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
                    Image(uiImage: UIImage(data: dropItemData)!).resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 0.35).padding(.bottom, 18)
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
}

#Preview {
    let goalData = GoalData(placeId: "", currentLatitude: 22, currentLongtitude: 11, selectedDistance: "")
    return ItemDropView(goalData: goalData)
}
