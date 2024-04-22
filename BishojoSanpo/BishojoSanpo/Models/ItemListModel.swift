//
//  ItemListModel.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/20.
//

import Foundation
import Combine

class ItemListModel: ObservableObject {
    @Published var catalog: Catalog?
    private var cancellables: Set<AnyCancellable> = []

    func fetchCatalog() async {
        let url = URL(string: "\(Constants.backendApiHost)/api/items")!
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: Catalog.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Decoding error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] catalog in
                self?.catalog = catalog
            })
            .store(in: &cancellables)
    }
}

// アイテムを表す構造体
struct Item: Codable, Identifiable {
    var id: Int
    var name: String
    var imageUrl: String
    var gainedAt: Date

    enum CodingKeys: String, CodingKey {
        case id, name, imageUrl = "image_url", gainedAt = "gained_at"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)

        let dateString = try container.decode(String.self, forKey: .gainedAt)
        if let formattedDate = DateFormatter.iso8601Full.date(from: dateString) {
            gainedAt = formattedDate
        } else {
            throw DecodingError.dataCorruptedError(forKey: .gainedAt, in: container, debugDescription: "Expected date string to be ISO8601-formatted.")
        }
    }
}

// カテゴリごとのアイテムを格納する構造体
struct Catalog: Codable {
    var hairs: [Item]
    var shoes: [Item]
    var bottoms: [Item]
    var tops: [Item]
}

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 9 * 60 * 60)
        formatter.locale = Locale(identifier: "ja-JP")
        return formatter
    }()
}
