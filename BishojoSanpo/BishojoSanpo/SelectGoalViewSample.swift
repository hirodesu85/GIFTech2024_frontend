//
//  SelectGoalViewSample.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/13.
//

// 遷移周りを定義するためにSelectGoalView.swift

import SwiftUI

struct SelectGoalViewSample: View {
    // --- 以下の一行を追加 ---
    @EnvironmentObject var router: NavigationRouter
    // ----------------------
    var body: some View {
        VStack{
            // デバッグ用ボタン
            Button(action: {
                router.items.append(.map) // ページ遷移
                
            }, label: {
                Text("APIを叩いてMapViewへ")
            })
            Button(action: {
                router.items.removeLast(router.items.count) // ページ遷移
                
            }, label: {
                Text("Home")
            })
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
}

#Preview {
    SelectGoalViewSample()
}
