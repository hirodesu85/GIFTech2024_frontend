//
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/04.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var router = NavigationRouter()
    @StateObject var locationManager = LocationManager()
    let bishojoViewWidth: Double = 350
    var body: some View {
        NavigationStack(path: $router.items){
            ZStack {
                
                BishojoView()
                    .position(x:170,y:400)
                    .scaleEffect(1.7)
                    .onTapGesture {
                        print("Tapped")
                    }
            
                
                NavigateToDressUpButton()
                NavigateToSelectGoalButton()
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
