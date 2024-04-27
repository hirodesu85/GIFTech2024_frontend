//
//  MyChatView.swift
//  BishojoSanpo
//
//  Created by 尾形拓夢 on 2024/04/12.
//

import SwiftUI

struct MyChatView: View {
    @Binding var isSelected: Bool
    @Binding var selectedOption: Int
    @Binding var isPressed: [Bool]
    
    let options: [String]
    
    var body: some View {
        HStack {
            ZStack {
                if (options.count > 1) {
                    WebPImageView(imageName: "SelectChat.webp")
                } else {
                    WebPImageView(imageName: "ChatNormalRight.webp")
                }
                
                VStack {
                    ForEach(0..<options.count, id: \.self) { index in
                        if isSelected {
                            Button(action: {
                            }) {
                                if self.selectedOption == index {
                                    ZStack {
                                        WebPImageView(imageName: "SelectedButton.webp")
                                            .padding(.horizontal, 20)
                                        Text(options[index])
                                            .foregroundStyle(Color("SelectedButtonColor"))
                                    }
                                } else {
                                    ZStack {
                                        WebPImageView(imageName: "NewNotSelectedButton.webp")
                                            .padding(.horizontal, 20)
                                        Text(options[index])
                                            .foregroundStyle(Color("NoSelectedButtonColor"))
                                    }
                                    
                                }
                            }
                            .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        } else {
                            Button(action: {
                                self.selectedOption = index
                                self.isSelected = true
                                ChatAudioPlayer.shared.playSound()
                            }) {
                                ZStack {
                                    WebPImageView(imageName: "WaitingButton.webp")
                                        .padding(.horizontal, 20)
                                    Text(options[index])
                                        .foregroundStyle(.white)
                                }
                                .scaleEffect(isPressed[index] ? 1.1 : 1)
                                .animation(.easeInOut(duration: 0.2), value: isPressed[index])
                            }
                            .simultaneousGesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged { _ in isPressed[index] = true }
                                    .onEnded { _ in isPressed[index] = false }
                            )
                        }
                    }
                }
                .padding(.bottom, 35)
            }
            .padding(.leading, 119)
            .padding(.bottom, 30)
            Spacer()
        }
    }
}


