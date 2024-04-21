//
//  HomeButtonView.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/21.
//

import SwiftUI

struct HomeButtonView: View {
    @EnvironmentObject var router: NavigationRouter
    var body: some View {
        
        Button(action: {
            router.returnToHome()
        }) {
            WebPImageView(imageName: "HomeButton.webp")
                .frame(width: 70, height: 70)
                .padding(.trailing, 12)
                .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .topTrailing)
                .padding(.top, 30)
            
        }
    }
}

#Preview {
    HomeButtonView()
}
