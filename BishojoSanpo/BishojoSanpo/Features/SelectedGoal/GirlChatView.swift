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
                HStack {
                    Text(girlText)
                        .foregroundStyle(Color("ChatColor"))
                        .font(.custom("NotoSansJP-VariableFont_wght", size: 25))
                        .padding(.bottom, 25)
                        .padding(.leading, 20)
                    Spacer()
                }
            }
            .offset(x: 0, y: -40)
            Spacer()
        }
        .padding(.top, 50)
    }
}

#Preview {
    GirlChatView(girlText: "どこまで行く？")
}
