//
//  RankView.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/22.
//

import SwiftUI

struct RankView: View {
    @ObservedObject var userDefaultsModel: UserDefaultsModel

    var body: some View {
        WebPImageView(imageName: "Rank_\(userDefaultsModel.rank).webp")
    }
}

