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
        Button(action: {
            router.items.append(.itemDrop(goalData: goalData))
        }, label: {
            WebPImageView(imageName: "ArrivedButton.webp")
                .frame(width: 150)
                .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .bottomLeading)
                .padding(.leading, 18)
                .padding(.bottom, 55)
        })
    }
}

#Preview {
    let goalData = GoalData()
    return ArrivedButtonView(goalData: goalData)
}
