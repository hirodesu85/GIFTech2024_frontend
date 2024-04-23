//
//  BishojoView.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/22.
//

import SwiftUI

struct BishojoView: View {
    
    var body: some View {
        GeometryReader{geometry in
            ZStack(alignment: .center){
                
                WebPImageView(imageName: "Character.webp")
                    .frame(width: geometry.size.width,height: geometry.size.height)
                
                WebPImageView(imageName: "Rank_7.webp")
                    .frame(width: geometry.size.width * 0.15)
                    .offset(y: -0.21 * geometry.size.height)
            }
        }
    }
    
}

#Preview {
    BishojoView()
}
