//
//  RankView.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/22.
//

import SwiftUI

struct RankView: View {
    let rank: Int
    var body: some View {
        WebPImageView(imageName: "Rank_\(rank).webp")
    }
}

#Preview {
    RankView(rank: 8)
}
