//
//  ItemListView.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/13.
//

import SwiftUI

struct ItemListView: View {
    @StateObject var itemListModel = ItemListModel()
    @State var selectedCategory: Int = 0
    
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        ZStack {
            WebPImageView(imageName: "Background.webp")
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .edgesIgnoringSafeArea(.all)
            
            WebPImageView(imageName: "Curtain.webp")
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .offset(x: -10, y: 0)
                .edgesIgnoringSafeArea(.all)
            
            WebPImageView(imageName: "ItemSign.webp")
                .frame(width: 230, height: 200)
                .offset(x: -80, y: -390)
                .edgesIgnoringSafeArea(.all)
            
            Button(action: {
                router.returnToHome()
            }) {
                WebPImageView(imageName: "HomeButton.webp")
                    .frame(width: 70, height: 70)
                    .padding(.trailing, 12)
            }
            .offset(x: 150, y: -370)
            
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 100)
                if let catalog = itemListModel.catalog {
                    ItemTable(itemListModel: itemListModel, selectedCategory: $selectedCategory)
                        .padding(.leading, 145)
                } else {
                    Text("データをロード中...")
                }
                
                Button(action: {
                }) {
                    WebPImageView(imageName: "ButtonDecide.webp")
                        .frame(width: 230, height: 230)
                        .offset(x: 0, y: -10)
                }
                .padding(.leading, 145)
            }.onAppear {
                Task {
                    await itemListModel.fetchCatalog()
                }
            }
        }
    }
}

#Preview {
    ItemListView()
}
