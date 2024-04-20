//
//  ItemListView.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/13.
//

import SwiftUI

struct ItemListView: View {
    @StateObject private var itemListModel = ItemListModel()
    var body: some View {
        VStack{
            if let catalog = itemListModel.catalog {
                Text("ロード完了")
            } else {
                Text("データをロード中...")
            }
        }.onAppear {
            itemListModel.loadCatalogData()
        }
        
    }
}

#Preview {
    ItemListView()
}
