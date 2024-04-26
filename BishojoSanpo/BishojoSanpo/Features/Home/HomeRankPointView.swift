//
//  HomeRankPointView.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/26.
//

import SwiftUI

struct HomeRankPointView: View {
    let nowRankPoint: Int
    let nextRankPoint: Int
    var body: some View {
        VStack(alignment: .trailing){
            HStack{
                WebPImageView(imageName: "Home_Nextpoint_Text.webp")
                Spacer(minLength: 5)
                Text(String(nextRankPoint)).font(.custom("NotoSansJP-Black", size: 16))
                    .foregroundColor(.white)
                    .shadow(color: Color.nextRankTextShadow, radius: 1)
                    .offset(y:-1.2)
                Spacer(minLength: 15)
            }
            .frame(width: 170)
            .offset(y:25)
            RankPointBarView(nowRankPoint: nowRankPoint, nextRankPoint: nextRankPoint)
        }
        
    }
    private func calculatePointRate() -> Double {
        let allRankPoint: Int = nowRankPoint + nextRankPoint
        return Double(nowRankPoint) / Double(allRankPoint)
    }
}

#Preview {
    HomeRankPointView(nowRankPoint: 10, nextRankPoint: 10)
}
