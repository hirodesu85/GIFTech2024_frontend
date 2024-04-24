//
//  UserDefaultsModel.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/23.
//

import Foundation
import Combine

class UserDefaultsModel: ObservableObject {
    @Published var rank: Int
    @Published var untilNextRank: Int
    @Published var currentRankPoint: Int
    @Published var currentWearing: [String: [String: String]] = [:]

    init() {
        UserDefaults.standard.register(defaults: [
                    "rank": 7,
                    "untilNextRank": 100,
                    "currentRankPoint": 0,
                    "currentWearing": [:]
                ])
        // UserDefaults から初期値を読み込む
        self.rank = UserDefaults.standard.integer(forKey: "rank")
        self.untilNextRank = UserDefaults.standard.integer(forKey: "untilNextRank")
        self.currentRankPoint = UserDefaults.standard.integer(forKey: "currentRankPoint")
    }


    func updateRank(newRank: Int) {
        UserDefaults.standard.set(newRank, forKey: "rank")
        self.rank = newRank
    }

    func updateUntilNextRank(newUntilNextRank: Int) {
        UserDefaults.standard.set(newUntilNextRank, forKey: "untilNextRank")
        self.untilNextRank = newUntilNextRank
    }

    func updateCurrentRankPoint(newCurrentRankPoint: Int) {
        UserDefaults.standard.set(newCurrentRankPoint, forKey: "currentRankPoint")
        self.currentRankPoint = newCurrentRankPoint
    }
    func updateWearingItem(category: String, itemId: String, imageUrl: String) {
            let itemData = ["id": itemId, "imageUrl": imageUrl]
            currentWearing[category] = itemData
            UserDefaults.standard.set(currentWearing, forKey: "currentWearing")
        }
}

