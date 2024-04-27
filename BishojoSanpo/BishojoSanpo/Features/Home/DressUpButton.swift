//
//  NavigateToDressUpButton.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/22.
//

import SwiftUI

struct DressUpButton: View {
    @EnvironmentObject var router: NavigationRouter
    @Binding var isPressed: Bool
    
    var body: some View {
        Button(action: {
            AudioPlayer.shared.playSound()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                router.items.append(.dressUp)
            }
        }, label: {
            WebPImageView(imageName: "Home_Button_Clothes.webp")
                .scaleEffect(isPressed ? 1.2 : 1)
                .animation(.easeInOut(duration: 0.2), value: isPressed)
            
        })
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }
}
