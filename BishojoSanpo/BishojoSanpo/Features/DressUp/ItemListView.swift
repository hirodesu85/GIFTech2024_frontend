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
                ScrollView {
                    ForEach(catalog.hairs, id: \.self.id) { hair in
                        VStack {
                            Text("hair_id: \(hair.id)")
                            Text("hair_name: \(hair.name)")
                            AsyncImage(url: URL(string: hair.imageUrl)) { phase in
                                if let image = phase.image {
                                    image.resizable()
                                } else if phase.error != nil {
                                    Text("画像読み込みエラー")
                                } else {
                                    Text("画像取得中...")
                                }
                            }.frame(width: 100, height: 100)
                            Text("hair_gained_at: \(String(describing: hair.gainedAt))")
                        }.padding(20)
                    }
                    ForEach(catalog.tops, id: \.self.id) { top in
                        VStack {
                            Text("top_id: \(top.id)")
                            Text("top_name: \(top.name)")
                            AsyncImage(url: URL(string: top.imageUrl)) { phase in
                                if let image = phase.image {
                                    image.resizable()
                                } else if phase.error != nil {
                                    Text("画像読み込みエラー")
                                } else {
                                    Text("画像取得中...")
                                }
                            }.frame(width: 100, height: 100)
                            Text("top_gained_at: \(String(describing: top.gainedAt))")
                        }.padding(20)
                    }
                    ForEach(catalog.bottoms, id: \.self.id) { bottom in
                        VStack {
                            Text("bottom_id: \(bottom.id)")
                            Text("bottom_name: \(bottom.name)")
                            AsyncImage(url:  URL(string: bottom.imageUrl)) { phase in
                                if let image = phase.image {
                                    image.resizable()
                                } else if phase.error != nil {
                                    Text("画像読み込みエラー")
                                } else {
                                    Text("画像取得中...")
                                }
                            }.frame(width: 100, height: 100)
                            Text("bottom_gained_at: \(String(describing: bottom.gainedAt))")
                        }.padding(20)
                    }
                    ForEach(catalog.shoes, id: \.self.id) { shoe in
                        VStack {
                            Text("shoe_id: \(shoe.id)")
                            Text("shoe_name: \(shoe.name)")
                            AsyncImage(url:  URL(string: shoe.imageUrl)) { phase in
                                if let image = phase.image {
                                    image.resizable()
                                } else if phase.error != nil {
                                    Text("画像読み込みエラー")
                                } else {
                                    Text("画像取得中...")
                                }
                            }.frame(width: 100, height: 100)
                            Text("shoes_gained_at: \(String(describing: shoe.gainedAt))")
                        }.padding(20)
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
    ItemListView()
}
