//
//  HeaderView.swift
//  BishojoSanpo
//
//  Created by 尾形拓夢 on 2024/04/12.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        WebPImageView(imageName: "SelectedButton.webp")
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    HeaderView()
}

