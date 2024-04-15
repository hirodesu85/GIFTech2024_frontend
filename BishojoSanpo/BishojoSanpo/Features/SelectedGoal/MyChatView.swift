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
            Spacer()
            ZStack {
                Image("UserChat")
                    .resizable()
                    .scaledToFit()
                    .frame(width:170, height:170)
                
                VStack {
                    ForEach(0..<options.count, id: \.self) { index in
                        Button(action: {
                            self.selectedOption = index
                            self.isSelected = true
                        }) {
                            Text(options[index])
                                .foregroundColor(self.selectedOption == index ? .white : .black)
                                .padding(8)
                                .background(self.selectedOption == index ? Color.cyan : Color.clear)
                        }
                        .disabled(isSelected)
                    }
                }
            }
            .padding()
        }
    }
}


