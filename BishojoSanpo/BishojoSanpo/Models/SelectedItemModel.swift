//
//  SelectedItem.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/26.
//

import Foundation

class SelectedItemModel: ObservableObject{
    @Published var hair: Int = -1
    @Published var top: Int = -1
    @Published var bottom: Int = -1
    @Published var shoes: Int = -1
    
    func updateSelectedItem(category: Int, itemId: Int) {
            switch category {
            case 0:
                self.hair = itemId
            case 1:
                self.top = itemId
            case 2:
                self.bottom = itemId
            case 3:
                self.shoes = itemId
            default:
                print("Invalid category")
            }
        }
}
