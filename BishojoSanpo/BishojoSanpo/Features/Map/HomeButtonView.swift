//
//  HomeButtonView.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/21.
//

import SwiftUI

struct HomeButtonView: View {
    @EnvironmentObject var router: NavigationRouter
    var body: some View {
        ZStack {
            // 画面の右上にボタンを配置する
            HStack {
                Spacer()
                VStack {
                    Button(action: {
                        router.returnToHome()
                    }) {
                        WebPImageView(imageName: "HomeButton.webp")
                            .frame(width: 55, height: 55)
                            .padding(.top, 25)
                            .padding(.trailing, 12)
                    }
                    Spacer()
                }
            }
        }
    }
}


#Preview {
    HomeButtonView()
}
