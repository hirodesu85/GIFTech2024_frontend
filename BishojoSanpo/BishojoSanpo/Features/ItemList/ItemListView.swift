//
//  ItemListView.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/13.
//

import SwiftUI

struct ItemListView: View {
    @EnvironmentObject var router: NavigationRouter
    var body: some View {
        VStack{
            Text("ItemListView")
            
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
    ItemListView()
}
