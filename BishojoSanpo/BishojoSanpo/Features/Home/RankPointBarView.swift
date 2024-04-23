//
//  RankPointBar.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/23.
//

import SwiftUI

struct RankPointBarView: View {
    let nowRankPoint: Int
    let nextRankPoint: Int
    var body: some View {
        VStack(alignment: .trailing){
            HStack{
                WebPImageView(imageName: "Home_Nextpoint_Text.webp")
                Spacer(minLength: 30)
                Text(String(nextRankPoint)).font(.custom("NotoSansJP-Black", size: 16))
                    .foregroundColor(.white)
                    .shadow(color: Color.nextRankTextShadow, radius: 1)
                    .offset(y:-1.2)
                Spacer(minLength: 20)
            }
            .frame(width: 170)
            .offset(y:25)
            ZStack(){
                WebPImageView(imageName: "HP_Empty.webp")
                WebPImageView(imageName: "HP_Move.webp")
                    .scaleEffect(x: calculatePointRate(), y: 1, anchor: .leading)
                    .padding()
                WebPImageView(imageName: "HP_Frame.webp")
            }
        }
        
    }
    private func calculatePointRate() -> Double {
        let allRankPoint: Int = nowRankPoint + nextRankPoint
        return Double(nowRankPoint) / Double(allRankPoint)
    }
}


#Preview {
    RankPointBarView(nowRankPoint: 10, nextRankPoint: 10)
}
