//
//  DetectTapView.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/21.
//

import SwiftUI

struct DetectTapView: View {
    @Binding var isTapped: Bool
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .frame(width: geometry.size.width, height: geometry.size.height)
                .contentShape(Rectangle()) // これにより透明な部分もタップ可能になる
                .onTapGesture {
                    isTapped = true
                }
        }
        .onAppear{
            KirakiraPlayer.shared.playSound()
        }
    }
}
