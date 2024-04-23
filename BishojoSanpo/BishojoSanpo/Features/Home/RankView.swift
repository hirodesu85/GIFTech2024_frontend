//
//  RankView.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/22.
//
import SwiftUI

struct RankView: View {
    var rank: Int
    private var imageName: String {
        "Rank_\(rank).webp"
    }
    var body: some View {
        VStack{
            WebPImageView(imageName: imageName)
        }
        
    }
}

