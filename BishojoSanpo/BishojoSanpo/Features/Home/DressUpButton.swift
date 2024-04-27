//
//  NavigateToDressUpButton.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/22.
//

import SwiftUI

struct DressUpButton: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        GeometryReader { geometry in
            Button(action: {
                AudioPlayer.shared.playSound()
                router.items.append(.dressUp)
            }, label: {
                WebPImageView(imageName: "Home_Button_Clothes.webp")
                
            })
            .frame(width: 150)
            .position(x: geometry.size.width - 85, y: geometry.size.height - 55) // ボタンの位置を右下に設定
        }
    }
}

#Preview {
    DressUpButton()
}
