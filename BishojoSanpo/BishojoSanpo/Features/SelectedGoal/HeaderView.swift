//
//  HeaderView.swift
//  BishojoSanpo
//
//  Created by 尾形拓夢 on 2024/04/12.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        Text("ここはヘッダー")
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 50)
            .background(Color.cyan)
            .foregroundStyle(.white)
    }
}

#Preview {
    HeaderView()
}

