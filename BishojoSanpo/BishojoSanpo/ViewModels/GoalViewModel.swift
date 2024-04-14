//
//  GoalViewModel.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/13.
//

import SwiftUI

class GoalViewModel: ObservableObject{
    @Published var selectedCategory: String = ""
    @Published var selectedDistance: String = ""
    @Published var placeId: String = ""
    
    // APIの繋ぎこみをする関数
    func api(){ // 名前はよしなにお願いします
        print(selectedCategory) // SelectGoalViewSampleで選択されたカテゴリ名がすでに変数内に入っています。よしなにお使いください
        print(selectedDistance) // こちらも同様です
        placeId = "hoge" // このような形でplaceIdを代入していただけるとMapViewの方で使えます
    }
    
}
