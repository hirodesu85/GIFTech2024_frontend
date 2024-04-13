//
//  ItemDropView.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/13.
//

import SwiftUI

struct ItemDropView: View {
    @EnvironmentObject var router: NavigationRouter
    var body: some View {
        VStack{
            Text("ItemDrop")
            
            Button(action: {
                router.items.removeLast(router.items.count)
                
            }, label: {
                Text("Home")
            })
            
            Button(action: {
                router.items.removeLast(router.items.count)
                router.items.append(.itemList)
                
            }, label: {
                Text("着せ替えする")
            })
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    ItemDropView()
}
