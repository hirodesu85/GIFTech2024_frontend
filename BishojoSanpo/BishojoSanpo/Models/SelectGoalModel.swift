//
//  GoalViewModel.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/13.
//

import SwiftUI

class SelectGoalModel {
    var currentLatitude: Double = 0.0
    var currentLongitude: Double = 0.0
    var selectedCategory: String = ""
    var selectedDistance: String = ""
    var placeId: String = ""
    var placeName: String = ""
    var placeImageUrl: String = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var errorMessage: String?
    
    func fetchSuggestedPlace() async {
        let urlString = "\(Constants.backendApiHost)/api/places/suggest?category=\(selectedCategory)&distance=\(selectedDistance)&lat=\(currentLatitude)&lng=\(currentLongitude)"
        guard let url = URL(string: urlString) else {
            self.errorMessage = "Invalid URL"
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let suggestedPlace = try JSONDecoder().decode(SuggestedPlace.self, from: data)
            self.placeId = suggestedPlace.place_id
            self.placeName = suggestedPlace.name
            self.placeImageUrl = suggestedPlace.image_url
            self.latitude = suggestedPlace.latitude
            self.longitude = suggestedPlace.longitude
        } catch {
            self.errorMessage = error.localizedDescription
            print(self.errorMessage ?? "")
        }
    }
}

struct SuggestedPlace: Codable {
    let place_id: String
    let name: String
    let image_url: String
    let latitude: Double
    let longitude: Double
}
