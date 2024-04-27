//
//  DressUp.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/20.
//

import SwiftUI

struct DressUpView: View {
    @EnvironmentObject var router: NavigationRouter
    @ObservedObject var userDefaultsModel: UserDefaultsModel

    var body: some View {
        VStack{
            Text("DressUpView")
            
            Button(action: {
                router.items.removeLast(router.items.count) // ページ遷移
                
            }, label: {
                Text("Home")
            })
            ItemListView(userDefaultsModel: userDefaultsModel)
        }
        .navigationBarBackButtonHidden(true)
        
    }
}


