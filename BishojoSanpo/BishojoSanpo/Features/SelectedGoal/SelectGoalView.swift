//
//  SelectGoalView.swift
//  BishojoSanpo
//
//  Created by 尾形拓夢 on 2024/04/12.
//

import SwiftUI

struct SelectGoalView: View {
    @State var isSelectedCategory: Bool = false
    @State var selectedCategory: Int = -1
    @State var isSelectedDistance: Bool = false
    @State var selectedDistance: Int = -1
    
    let categoryOptions = ["wwwwwwww", "www", "wwwwwwwwww"]
    let distanceOptions = ["wwwwwwww", "www", "wwwwwwwwww"]
    
    var body: some View {
        ZStack {
            WebPImageView(imageName: "Background.webp")
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .edgesIgnoringSafeArea(.all)

            ZStack(alignment: .top) {
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack {
                            Color.clear
                                .frame(width: .infinity, height: 80)
                            
                            GirlChatView(girlText: "wwwwwww")
                            MyChatView(isSelected: $isSelectedCategory,
                                       selectedOption: $selectedCategory,
                                       options: categoryOptions)
                            if isSelectedCategory {
                                GirlChatView(girlText: "wwwwwwwwwww")
                                MyChatView(isSelected: $isSelectedDistance,
                                           selectedOption: $selectedDistance,
                                           options: distanceOptions)
                                Color.clear.id(1)
                                    .frame(width: .infinity, height: 80)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .onChange(of: isSelectedCategory) { _ in
                        withAnimation {
                            proxy.scrollTo(1)
                        }
                    }
                }
                HeaderView()
            }
        }
    }

}

#Preview {
    SelectGoalView()
}
