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
    var errorMessage: String?
    
    func fetchRewardData(goalData: GoalData) async { // ここに到着APIとの繋ぎこみをお願いします
        let requestBody = ArriveRequestBody(place_id: goalData.placeId, distance: goalData.selectedDistance)
        
        guard let url = URL(string: "\(Constants.backendApiHost)/api/places/arrive") else {
            self.errorMessage = "Invalid URL"
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        do {
            request.httpBody = try JSONEncoder().encode(requestBody)
            let (data, _) = try await URLSession.shared.data(for: request)
            let responseBody: ArriveResponseBody = try JSONDecoder().decode(ArriveResponseBody.self, from: data)
            self.dropItem = responseBody.item
            self.rank = responseBody.rank
            self.untilNextRank = responseBody.until_next_rank
            self.getRankPoint = responseBody.get_rank_point
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }

}

struct ArriveRequestBody: Codable {
    var place_id: String
    var distance: String
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

struct ArriveResponseBody: Codable {
    var item: DropItem
    var rank: Int
    var until_next_rank: Int
    var get_rank_point: Int
}

// ランク関連のCodable
