//
//  ItemTable.swift
//  BishojoSanpo
//
//  Created by 尾形拓夢 on 2024/04/23.
//

import SwiftUI

struct ItemTable: View {
    @ObservedObject var itemListModel: ItemListModel
    @Binding var selectedCategory: Int
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    
    var body: some View {
        VStack(spacing: 0) {
            if let catalog = itemListModel.catalog {
                HStack(alignment: .bottom, spacing: 0) {
                    Button(action: {
                        selectedCategory = 0
                    }) {
                        if selectedCategory == 0 {
                            WebPImageView(imageName: "TagActiveHair.webp")
                                .frame(width: 50)
                        } else {
                            WebPImageView(imageName: "TagNormalHair.webp")
                                .frame(width: 50)
                        }
                    }
                    
                    Button(action: {
                        selectedCategory = 1
                    }) {
                        if selectedCategory == 1 {
                            WebPImageView(imageName: "TagActiveOver.webp")
                                .frame(width: 50)
                        } else {
                            WebPImageView(imageName: "TagNormalOver.webp")
                                .frame(width: 50)
                        }
                    }
                    
                    Button(action: {
                        selectedCategory = 2
                    }) {
                        if selectedCategory == 2 {
                            WebPImageView(imageName: "TagActiveUnder.webp")
                                .frame(width: 50)
                        } else {
                            WebPImageView(imageName: "TagNormalUnder.webp")
                                .frame(width: 50)
                        }
                    }
                    
                    Button(action: {
                        selectedCategory = 3
                    }) {
                        if selectedCategory == 3 {
                            WebPImageView(imageName: "TagActiveShoes.webp")
                                .frame(width: 50)
                        } else {
                            WebPImageView(imageName: "TagNormalShoes.webp")
                                .frame(width: 50)
                        }
                    }
                    
                }
                
                ZStack {
                    WebPImageView(imageName: "NewBackWhite.webp")
                        .scaledToFill()
                        .frame(width: 200, height: 450)
                        .clipped()
                        .blur(radius: 3.0)
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 5) {
                            ForEach(itemsForSelectedCategory(catalog: catalog), id: \.self.id) { item in
                                ZStack {
                                    WebPImageView(imageName: "ItemBlank.webp")
                                        .frame(width: 100, height: 100)
                                    AsyncImage(url: URL(string: item.imageUrl)) { phase in
                                        if let image = phase.image {
                                            image.resizable()
                                        } else if phase.error != nil {
                                            Text("画像読み込みエラー")
                                        } else {
                                            Text("画像取得中...")
                                        }
                                    }.frame(width: 55, height: 55)
                                        .offset(x: -3, y: 3)
                                }
                            }
                            
                            ForEach(0..<12-itemsForSelectedCategory(catalog: catalog).count, id: \.self) { _ in
                                WebPImageView(imageName: "ItemLock.webp")
                                    .frame(width: 100, height: 100)
                            }
                        }
                    }
                    .frame(width: 200, height: 450)
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
    
    func itemsForSelectedCategory(catalog: Catalog) -> [Item] {
        switch selectedCategory {
        case 0:
            return catalog.hairs
        case 1:
            return catalog.tops
        case 2:
            return catalog.bottoms
        case 3:
            return catalog.shoes
        default:
            return []
        }
    }
}

#Preview {
    ItemListView()
}
