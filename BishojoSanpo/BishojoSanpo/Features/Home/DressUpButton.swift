//
//  NavigateToDressUpButton.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/22.
//

import SwiftUI

struct DressUpButton: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        
            Button(action: {
                router.items.append(.dressUp)
            }, label: {
                WebPImageView(imageName: "Home_Button_Clothes.webp")
                
            })

    }
}

#Preview {
    DressUpButton()
}
