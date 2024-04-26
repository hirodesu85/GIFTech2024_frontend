//
//  BishojoView.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/22.
//

import SwiftUI

struct BishojoView: View {
    var userDefaultsModel: UserDefaultsModel
    var hairId: Int
    var topId: Int
    var bottomId: Int
    var shoesId: Int
    
    init(userDefaultsModel: UserDefaultsModel) {
        self.userDefaultsModel = userDefaultsModel
        self.hairId = self.userDefaultsModel.currentWearingId["hair"] as! Int
        self.topId = self.userDefaultsModel.currentWearingId["top"] as! Int
        self.bottomId = self.userDefaultsModel.currentWearingId["bottom"] as! Int
        self.shoesId = self.userDefaultsModel.currentWearingId["shoes"] as! Int
    }
    
    var body: some View {
        WebPImageView(imageName: "Character\(hairId)_\(topId)_\(bottomId)_\(shoesId).webp")
    }
    
}

#Preview {
    var userDefaultsModel = UserDefaultsModel()
    return BishojoView(userDefaultsModel: userDefaultsModel)
}
