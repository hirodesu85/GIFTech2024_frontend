//
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/04.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var router = NavigationRouter()
    @StateObject var locationManager = LocationManager()
    var body: some View {
        NavigationStack(path: $router.items){
            VStack {
                
                Button(action: {
                    router.items.append(.selectGoal)
                    print(router)
                }, label: {
                    Text("お散歩")
                })
                
                Button(action: {
                    router.items.append(.itemList)
                    
                }, label: {
                    Text("着替える")
                })
            }
            // 画面遷移定義
            .navigationDestination(for: NavigationRouter.Item.self) { item in
                switch item{
                case .selectGoal:
                    SelectGoalView(locationManager: locationManager)
                case .map(let goalData):
                    MapView(locationManager: locationManager, goalData: goalData)
                case .itemDrop(let goalData):
                    ItemDropView(goalData: goalData)
                case .itemList:
                    ItemListView()
                }
            }
        }
        .environmentObject(router)
        
    }
}

#Preview {
    HomeView()
}
