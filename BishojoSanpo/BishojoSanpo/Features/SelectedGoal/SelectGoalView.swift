//
//  SelectGoalView.swift
//  BishojoSanpo
//
//  Created by 尾形拓夢 on 2024/04/12.
//

import SwiftUI

struct SelectGoalView: View {
    @State var isSelectedCategory: Bool = false
    @State var selectedCategory: Int = 0
    @State var isSelectedDistance: Bool = false
    @State var selectedDistance: Int = 0
    
    let categoryOptions = ["サウナ", "温泉", "散歩"]
    let distanceOptions = ["遠くまで（60分）", "中距離（30分）", "近く（10分）"]
    
    var body: some View {
        VStack {
            HeaderView()
            ScrollView {
                VStack {
                    GirlChatView(girlText: "どこに行く？")
                    MyChatView(isSelected: $isSelectedCategory,
                               selectedOption: $selectedCategory,
                               options: categoryOptions)
                    if isSelectedCategory {
                        GirlChatView(girlText: "どこまで行く？")
                        MyChatView(isSelected: $isSelectedDistance,
                                   selectedOption: $selectedDistance,
                                   options: distanceOptions)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    SelectGoalView()
}
