//
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/04.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var router = NavigationRouter()
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
                    router.items.append(.dressUp)
                    
                }, label: {
                    Text("着替える")
                })
            }
            // 画面遷移定義
            .navigationDestination(for: NavigationRouter.Item.self) { item in
                switch item{
                case .selectGoal:
                    SelectGoalView()
                        .environment(\.font, .custom("NotoSansJP-Black", size: 25))
                case .map(let goalData):
                    MapView(goalData: goalData)
                case .itemDrop(let goalData):
                    ItemDropView(goalData: goalData)
                case .dressUp:
                    DressUpView()
                }
            }
        }
        .environmentObject(router)
        
    }
}

#Preview {
    HomeView()
}
