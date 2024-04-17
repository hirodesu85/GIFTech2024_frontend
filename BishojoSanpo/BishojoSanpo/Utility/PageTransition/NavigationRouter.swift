//
//  PagePath.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/13.
//
import SwiftUI

final class NavigationRouter: ObservableObject {
    @MainActor @Published var items: [Item] = []
    
    enum Item: Hashable {
        case selectGoal
        case map(goalData: GoalData)
        case itemDrop
        case itemList
    }
    
    @MainActor func navigateToMap(with data: GoalData) {
        items.append(.map(goalData: data))
    }

    @MainActor func returnToHome() {
        items.removeAll()  // Homeへ完全に戻る
    }
}

struct GoalData: Hashable {
    var placeId: String = ""
    var latitude: Double = 0
    var longtitude: Double = 0
    var selectedDistance: String = ""

    mutating func update(from viewModel: SelectGoalModel) {
        placeId = viewModel.placeId
        latitude = viewModel.latitude
        longtitude = viewModel.longitude
        selectedDistance = viewModel.selectedDistance
    }
}

struct RewardData: Hashable {
    
}

struct ItemData: Hashable {
    
}
