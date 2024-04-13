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
    case selectGoal, map, itemDrop, itemList
  }
}
