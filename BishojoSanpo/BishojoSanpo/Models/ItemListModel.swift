//
//  ItemListModel.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/20.
//

import Foundation

class ItemListModel: ObservableObject{
    @Published var catalog: Catalog?
    
    // APIからカタログデータを非同期で取得するメソッドの例(ChatGPT出力です。自由に変えてくださって大丈夫です！)
    func loadCatalogData() {
        let url = URL(string: "https://example.com/api/catalog")! // APIのURLに置き換えてください
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601 // 日付の形式に応じて変更する
                let catalogData = try decoder.decode(Catalog.self, from: data)
                DispatchQueue.main.async {
                    self?.catalog = catalogData
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }
        task.resume()
    }
}

// アイテムを表す構造体
struct Item: Codable {
    var id: Int
    var name: String
    var imageUrl: String
    var gainedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id, name, imageUrl = "image_url", gainedAt = "gained_at"
    }
}

// カテゴリごとのアイテムを格納する構造体
struct Catalog: Codable {
    var hairs: [Item]
    var shoes: [Item]
    var bottoms: [Item]
    var tops: [Item]
}


