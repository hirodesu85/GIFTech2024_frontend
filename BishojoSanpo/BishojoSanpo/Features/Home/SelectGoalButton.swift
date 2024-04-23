//
//  NavigateToSelectGoalButton.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/22.
//

import SwiftUI

struct SelectGoalButton: View {
    @EnvironmentObject var router: NavigationRouter
    var body: some View {
        GeometryReader { geometry in
            Button(action: {
                router.items.append(.selectGoal)
            }, label: {
                WebPImageView(imageName: "Home_Button_Go.webp")
                
            })
            .frame(width: 200)
            .position(x: geometry.size.width - 105, y: geometry.size.height - 200) // ボタンの位置を右下に設定
        }
    }
}

#Preview {
    SelectGoalButton()
}
