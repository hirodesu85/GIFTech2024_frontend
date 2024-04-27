//
//  ArrivedButtonView.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/21.
//

import SwiftUI

struct ArrivedButtonView: View {
    @EnvironmentObject var router: NavigationRouter
    @Binding var isPressed: Bool
    let goalData: GoalData
    var body: some View {
        ZStack {
            // 画面の左下にボタンを配置する
            HStack {
                VStack {
                    Spacer()
                    Button(action: {
                        
                        AudioPlayer.shared.playSound()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            router.navigateToItemDrop(with: goalData)
                        }
                    }) {
                        WebPImageView(imageName: "ArrivedButton.webp")
                            .scaleEffect(isPressed ? 1.2 : 1)
                            .animation(.easeInOut(duration: 0.2), value: isPressed)
                            .frame(width: 150, height: 100) // ここで高さも指定
                            .padding(.bottom, 18)
                            .padding(.leading, 18)
                    }
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in isPressed = true }
                            .onEnded { _ in isPressed = false }
                    )
                    
                }
                Spacer()
            }
        }
    }
}
