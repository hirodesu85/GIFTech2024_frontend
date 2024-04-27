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
    @Published var currentWearingId: [String:Any] = [:]
    
    static let shared = UserDefaultsModel()
    
    private init() {
        UserDefaults.standard.register(defaults: [
            "rank": 7,
            "untilNextRank": 100,
            "currentRankPoint": 0,
            "currentWearingId": [
                "hair": 1,
                "top": 1,
                "bottom": 1,
                "shoes": 1
            ]
        ])
        // UserDefaults から初期値を読み込む
        self.rank = UserDefaults.standard.integer(forKey: "rank")
        self.untilNextRank = UserDefaults.standard.integer(forKey: "untilNextRank")
        self.currentRankPoint = UserDefaults.standard.integer(forKey: "currentRankPoint")
        self.currentWearingId = UserDefaults.standard.dictionary(forKey: "currentWearingId") ?? [:]
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
    func updateWearingItem(hair: Int, top: Int, bottom: Int, shoes: Int) {
        
        currentWearingId["hair"] = hair
        currentWearingId["top"] = top
        currentWearingId["bottom"] = bottom
        currentWearingId["shoes"] = shoes
        
        UserDefaults.standard.set(currentWearingId, forKey: "currentWearingId")
    }
}

