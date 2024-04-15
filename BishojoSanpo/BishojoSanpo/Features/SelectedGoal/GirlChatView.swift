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
        HStack {
            Image("SampleIcon")
                .resizable()
                .frame(width: 60, height: 60)
                .padding()
            ZStack {
                Image("GirlChat")
                    .resizable()
                    .scaledToFit()
                    .frame(width:150, height: 60)
                Text(girlText)
            }
            Spacer()
        }
    }
}

#Preview {
    GirlChatView(girlText: "どこまで行く？")
}
