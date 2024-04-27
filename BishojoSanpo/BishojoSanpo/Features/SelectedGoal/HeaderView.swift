//
//  HeaderView.swift
//  BishojoSanpo
//
//  Created by 尾形拓夢 on 2024/04/12.
//

import SwiftUI

struct HeaderView: View {
    
    @EnvironmentObject var router: NavigationRouter
    @Binding var isPressedHome: Bool
    
    var body: some View {
        ZStack {
            WebPImageView(imageName: "NewHeader.webp")
                .edgesIgnoringSafeArea(.all)
                .shadow(color: Color(red: 0, green: 0, blue: 0.2, opacity: 0.35),
                        radius: 10,
                        x: 0, y: 5)
            HStack {
                Text("音子")
                    .padding(.leading, 25)
                    .padding(.top, 25)
                    .padding(.bottom, 15)
                    .foregroundStyle(.white)
                Spacer()
                Button(action: {
                    AudioPlayer.shared.playSound()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        router.returnToHome()
                    }
                }) {
                    WebPImageView(imageName: "HomeButton.webp")
                        .frame(width: 55, height: 55)
                        .padding(.trailing, 12)
                        .scaleEffect(isPressedHome ? 1.2 : 1)
                        .animation(.easeInOut(duration: 0.2), value: isPressedHome)
                }
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in isPressedHome = true }
                        .onEnded { _ in isPressedHome = false }
                )
            }
        }
    }
}

