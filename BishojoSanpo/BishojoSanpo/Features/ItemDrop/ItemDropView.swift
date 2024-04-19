//
//  ItemDropView.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/13.
//

import SwiftUI

struct ItemDropView: View {
    @EnvironmentObject var router: NavigationRouter
    let goalData: GoalData
    var body: some View {
        VStack{
            Text("ItemDrop")
            Text("PlaceId : "+goalData.placeId)
            Text("selectedDistance : "+goalData.selectedDistance)
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
    let goalData = GoalData(placeId: "", currentLatitude: 22, currentLongtitude: 11, selectedDistance: "")
    return ItemDropView(goalData: goalData)
}
