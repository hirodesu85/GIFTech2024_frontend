//
//  LottieSampleView.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/21.
//

import SwiftUI
import Lottie

struct LottieSampleView: View {
    var body: some View {
        LottieView(animation: .named("LottieLego"))
            .playing(loopMode: .loop)
    }
}

#Preview {
    LottieSampleView()
}
