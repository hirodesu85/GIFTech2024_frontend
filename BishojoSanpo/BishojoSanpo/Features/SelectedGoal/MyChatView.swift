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
    
    let options: [String]
    
    var body: some View {
        HStack {
            ZStack {
                WebPImageView(imageName: "SelectChat.webp")
                
                VStack {
                    ForEach(0..<options.count, id: \.self) { index in
                        if isSelected {
                            Button(action: {
                            }) {
                                if self.selectedOption == index {
                                    WebPImageView(imageName: "NoSelectedButton.webp")
                                        .padding(.horizontal, 20)
                                } else {
                                    WebPImageView(imageName: "NoSelectedButton.webp")
                                        .padding(.horizontal, 20)
                                }
                            }
                            .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        } else {
                            Button(action: {
                                self.selectedOption = index
                                self.isSelected = true
                            }) {
                                WebPImageView(imageName: "WaitingButton.webp")
                                    .padding(.horizontal, 20)
                            }
                        }
                    }
                }
                .padding(.bottom, 35)
            }
            .padding(.leading, 119)
            Spacer()
        }
    }
}


