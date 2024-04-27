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
    @ObservedObject var userDefaultsModel: UserDefaultsModel
    @State var selectedItemModel = SelectedItemModel()
    
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
            
            CharacterView(userDefaultsModel: userDefaultsModel)
                .scaleEffect(0.83)
                .offset(x:-75,y:35)
            
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 100)
                ZStack{
                    if let catalog = itemListModel.catalog {
                        ItemTable(itemListModel: itemListModel, userDefaultsModel: userDefaultsModel, selectedCategory: $selectedCategory, selectedItemModel: selectedItemModel)

                    } else {
                        WebPImageView(imageName: "NewBackWhite.webp")
                            .scaledToFill()
                            .frame(width: 200, height: 494)
                            .clipped()
                            .blur(radius: 3.0)
                        Text("Loading...").foregroundStyle(Color("ChatColor"))
                            .font(.headline)

                    }
                }.padding(.leading, 145)
                
                
                Button(action: {
                    updateUserDefaulsWearing()
                }) {
                    WebPImageView(imageName: "ButtonDecide.webp")
                        .frame(width: 230, height: 230)
                        .offset(x: 0, y: -10)
                }
                .padding(.leading, 145)
            }.onAppear {
                BgmPlayer.shared.playBackgroundMusic(filename: "bgm_dressUp")
                Task {
                    await itemListModel.fetchCatalog()
                }
            }
        }
    }
    func updateUserDefaulsWearing(){
        
        userDefaultsModel.updateWearingItem(
            hair: selectedItemModel.hair == -1 ? userDefaultsModel.currentWearingId["hair"]  as! Int : selectedItemModel.hair,
            top: selectedItemModel.top == -1 ? userDefaultsModel.currentWearingId["top"] as! Int: selectedItemModel.top,
            bottom: selectedItemModel.bottom == -1 ? userDefaultsModel.currentWearingId["bottom"] as! Int: selectedItemModel.bottom,
            shoes: selectedItemModel.shoes == -1 ? userDefaultsModel.currentWearingId["shoes"] as! Int: selectedItemModel.shoes)
    }
}
#Preview {
    ItemListView(itemListModel: ItemListModel(), selectedCategory: 1, userDefaultsModel: UserDefaultsModel(), selectedItemModel: SelectedItemModel())
}
