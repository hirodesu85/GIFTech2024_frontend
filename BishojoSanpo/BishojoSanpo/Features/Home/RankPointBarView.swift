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
        ZStack{
            WebPImageView(imageName: "HP_Empty.webp")
            WebPImageView(imageName: "HP_Move.webp")
                .scaleEffect(x: calculatePointRate()*1.02, y: 1, anchor: .leading)
                .padding()
                .offset(x:-1.2)
            WebPImageView(imageName: "HP_Frame.webp")
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
