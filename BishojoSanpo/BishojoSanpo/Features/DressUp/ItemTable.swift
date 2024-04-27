//
//  ItemTable.swift
//  BishojoSanpo
//
//  Created by 尾形拓夢 on 2024/04/23.
//

import SwiftUI

struct ItemTable: View {
    @ObservedObject var itemListModel: ItemListModel
    @ObservedObject var userDefaultsModel: UserDefaultsModel
    @Binding var selectedCategory: Int
    @ObservedObject var selectedItemModel: SelectedItemModel
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    let categories = ["hair", "top", "bottom", "shoes"]
    
    
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
                    ScrollViewReader { proxy in
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 5) {
                                ForEach(itemsForSelectedCategory(catalog: catalog), id: \.self.id) { item in
                                    ZStack {
                                        AsyncImage(url: URL(string: item.imageUrl)) { phase in
                                            if let image = phase.image {
                                                image.resizable()
                                            } else if phase.error != nil {
                                                Text("画像読み込みエラー")
                                            } else {
                                                Text("Loading...").foregroundStyle(Color("ChatColor"))
                                                    .font(.caption)
                                            }
                                        }
                                        .frame(width: 100, height: 100)
                                        .onTapGesture {
                                            if isSelectedItem(itemId: item.id){
                                                selectedItemModel.updateSelectedItem(category: selectedCategory, itemId: -1)
                                               
                                            }else{
                                                selectedItemModel.updateSelectedItem(category: selectedCategory, itemId: item.id)
                                                
                                            }
                                        }
                                        if isSelectedItem(itemId: item.id){
                                            WebPImageView(imageName: "Cursor.webp").allowsHitTesting(false)
                                        }
                                        if isEquipped(itemId: item.id){
                                            WebPImageView(imageName: "Equipment.webp")
                                                .frame(width: 35)
                                                .offset(x:30,y:-30)
                                                .allowsHitTesting(false)
                                        }
                                    }
                                }
                                
                                ForEach(0..<12-itemsForSelectedCategory(catalog: catalog).count, id: \.self) { _ in
                                    WebPImageView(imageName: "ItemLock.webp")
                                        .frame(width: 100, height: 100)
                                }
                            }
                        }
                        .frame(width: 200, height: 450)
                        .onChange(of: selectedCategory) { _ in
                            withAnimation {
                                proxy.scrollTo(1)
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
    func isEquipped(itemId: Int) -> Bool {
        
        let selectedCategoryString = categories[min(selectedCategory, categories.count - 1)]
        return self.userDefaultsModel.currentWearingId[selectedCategoryString] as? Int == itemId
    }
    func isSelectedItem(itemId: Int) -> Bool {
        switch selectedCategory {
            case 0:
                return selectedItemModel.hair == itemId
            case 1:
                return selectedItemModel.top == itemId
            case 2:
                return selectedItemModel.bottom == itemId
            case 3:
                return selectedItemModel.shoes == itemId
            default:
                return false
            }
    }
    
    
    
}
