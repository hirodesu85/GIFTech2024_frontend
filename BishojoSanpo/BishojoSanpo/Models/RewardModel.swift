//
//  RewardModel.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/21.
//

import Foundation

class RewardModel: ObservableObject {
    @Published var dropItem: DropItem?
    @Published var rank: Int?
    @Published var untilNextRank: Int?
    @Published var getRankPoint: Int?
    
    func fetchRewardData(goalData: GoalData){ // ここに到着APIとの繋ぎこみをお願いします
        let place_id = goalData.placeId
        let distance = goalData.selectedDistance
    }

}

struct DropItem: Codable {
    var category: String
    var id: Int
    var name: String
    var imageUrl: String

    enum CodingKeys: String, CodingKey {
        case category, id, name, imageUrl = "image_url"
    }
}

// ランク関連のCodable
