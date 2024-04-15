//
//  GoalViewModel.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/13.
//

import SwiftUI

class GoalViewModel: ObservableObject{
    @Published var currentLatitude: Double = 0.0
    @Published var currentLongitude: Double = 0.0
    @Published var selectedCategory: String = ""
    @Published var selectedDistance: String = ""
    @Published var placeId: String = ""
    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0
    @Published var errorMessage: String?
    
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
            self.latitude = suggestedPlace.latitude
            self.longitude = suggestedPlace.longitude
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}

struct SuggestedPlace: Codable {
    let place_id: String
    let latitude: Double
    let longitude: Double
}
