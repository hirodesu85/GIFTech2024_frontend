//
//  ItemTable.swift
//  BishojoSanpo
//
//  Created by 尾形拓夢 on 2024/04/23.
//

import SwiftUI

struct ItemTable: View {
    @StateObject private var itemListModel = ItemListModel()
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        VStack(spacing: 0) {
            if let catalog = itemListModel.catalog {
                HStack(spacing:0) {
                    WebPImageView(imageName: "TagNormalHair.webp")
                    WebPImageView(imageName: "TagNormalHair.webp")
                    WebPImageView(imageName: "TagNormalHair.webp")
                    WebPImageView(imageName: "TagNormalHair.webp")
                }
                ZStack {
                    WebPImageView(imageName: "BackWhite.webp")
                        .frame(width: 377)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(catalog.hairs, id: \.self.id) { hair in
                                ZStack {
                                    WebPImageView(imageName: "ItemBlank.webp")
                                        .frame(width: 170, height: 170)
                                    AsyncImage(url: URL(string: hair.imageUrl)) { phase in
                                        if let image = phase.image {
                                            image.resizable()
                                        } else if phase.error != nil {
                                            Text("画像読み込みエラー")
                                        } else {
                                            Text("画像取得中...")
                                        }
                                    }.frame(width: 100, height: 100)
                                }
                            }
                            
                            ForEach(0..<12-catalog.hairs.count, id: \.self) { _ in
                                WebPImageView(imageName: "ItemLock.webp")
                                    .frame(width: 170, height: 170)
                            }
                        }
                    }
                }
            } else {
                Text("データをロード中...")
            }
        }.onAppear {
            Task {
                await itemListModel.fetchCatalog()
            }
        }
    }
}

#Preview {
    ItemTable()
}
