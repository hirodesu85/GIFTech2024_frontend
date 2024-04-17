//
//  GirlChatView.swift
//  BishojoSanpo
//
//  Created by 尾形拓夢 on 2024/04/12.
//

import SwiftUI

struct GirlChatView: View {
    let girlText :String
    var body: some View {
        HStack(spacing: 0) {
            WebPImageView(imageName: "GirlIcon.webp")
                .frame(width: 100, height: 100)
                .padding(10)
            ZStack {
                WebPImageView(imageName: "ChatNormalLeft.webp")
                Text(girlText)
                    .padding(.bottom, 25)
            }
            .padding(.bottom, 100)
            Spacer()
        }
    }
}

#Preview {
    GirlChatView(girlText: "どこまで行く？")
}
