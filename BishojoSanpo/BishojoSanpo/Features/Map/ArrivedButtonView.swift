//
//  ArrivedButtonView.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/21.
//

import SwiftUI

struct ArrivedButtonView: View {
    @EnvironmentObject var router: NavigationRouter
    let goalData: GoalData
    var body: some View {
        ZStack {
            // 画面の左下にボタンを配置する
            HStack {
                VStack {
                    Spacer()
                    Button(action: {
                        router.navigateToItemDrop(with: goalData)
                        print("a")
                    }) {
                        WebPImageView(imageName: "ArrivedButton.webp")
                            .frame(width: 150, height: 100) // ここで高さも指定
                            .padding(.bottom, 18)
                            .padding(.leading, 18)
                    }
                }
                Spacer()
            }
        }
    }
}


#Preview {
    let goalData = GoalData()
    return ArrivedButtonView(goalData: goalData)
}
