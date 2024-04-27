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
                        AudioPlayer.shared.playSound()
                    }) {
                        WebPImageView(imageName: "HomeButton.webp")
                            .frame(width: 70, height: 70)
                            .padding(.top, 15)
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
