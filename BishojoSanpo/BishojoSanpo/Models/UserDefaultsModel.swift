//
//  UserDefaultsModel.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/23.
//

import Foundation

class UserDefaultsModel {
    init() {
        UserDefaults.standard.register(defaults: [
            "rank": 7,
            "untilNextRank": 100,
            "currentRankPoint": 0
        ])
    }

    var rank: Int {
        get {
            return UserDefaults.standard.integer(forKey: "rank")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "rank")
        }
    }
    
    var untilNextRank: Int{
        get {
            return UserDefaults.standard.integer(forKey: "untilNextRank")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "untilNextRank")
        }
    }
    var currentRankPoint: Int{
        get {
            return UserDefaults.standard.integer(forKey: "currentRankPoint")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "currentRankPoint")
        }
    }
    
    
    
}

