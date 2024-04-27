//
//  NavigateToSelectGoalButton.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/22.
//

import SwiftUI

struct SelectGoalButton: View {
    @EnvironmentObject var router: NavigationRouter
    let userDefaultsModel = UserDefaultsModel.shared
    var body: some View {
            Button(action: {
                AudioPlayer.shared.playSound()
                router.items.append(.selectGoal)
                print(userDefaultsModel.currentRankPoint)
            }, label: {
                WebPImageView(imageName: "Home_Button_Go.webp")
                
            })

    }
}

#Preview {
    SelectGoalButton()
}
