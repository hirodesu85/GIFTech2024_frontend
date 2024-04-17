//
//  Direction.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/17.
//

import Foundation
import GoogleMaps

class DirectionModel {
    /// 経路検索APIのエンドポイント. 経路検索APIはSDKとして提供されていないため、エンドポイントはベタ書きになります
    let baseUrl = "https://maps.googleapis.com/maps/api/directions/json"

    
    
    // 現在地から目的地までのルートを検索する
    func getDirection(destination: String, start startLocation: String) -> Direction? {
        guard var components = URLComponents(string: baseUrl) else { return nil }

        components.queryItems = [
            URLQueryItem(name: "key", value: Constants.apiKey),
            URLQueryItem(name: "origin", value: startLocation),
            URLQueryItem(name: "destination", value: destination)
        ]

        guard let url = components.url else { return nil }

        let semaphore = DispatchSemaphore(value: 0)
        var directionResult: Direction?

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            defer { semaphore.signal() }

            if let data = data {
                let decoder = JSONDecoder()
                do {
                    directionResult = try decoder.decode(Direction.self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                print(error?.localizedDescription ?? "Error")
            }
        }
        task.resume()
        
        semaphore.wait() // この行でHTTPリクエストの完了を待機
        return directionResult
    }

    
    func createPolyline(from direction: Direction) -> GMSPolyline? {
        // direction から最初の route とその最初の leg を取得する
        guard let route = direction.routes.first, let leg = route.legs.first else { return nil }
        
        // 経路の各ステップから線を描画するためのパスを生成
        let path = GMSMutablePath()
        for step in leg.steps {
            // 各ステップの開始地点と終了地点をパスに追加
            path.add(CLLocationCoordinate2D(latitude: step.startLocation.lat,
                                            longitude: step.startLocation.lng))
            path.add(CLLocationCoordinate2D(latitude: step.endLocation.lat,
                                            longitude: step.endLocation.lng))
        }
        
        // パスからポリラインを生成
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 4.0
        
        // ポリラインオブジェクトを返す
        return polyline
    }

}


struct Direction: Codable {
    let routes: [Route]
}

struct Route: Codable {
    let legs: [Leg]
}

struct Leg: Codable {
    /// 経路のスタート座標
    let startLocation: LocationPoint
    /// 経路の目的地の座標
    let endLocation: LocationPoint
    /// 経路
    let steps: [Step]
    
    enum CodingKeys: String, CodingKey {
        case startLocation = "start_location"
        case endLocation = "end_location"
        case steps
    }
}

struct Step: Codable {
    let startLocation: LocationPoint
    let endLocation: LocationPoint
    
    enum CodingKeys: String, CodingKey {
        case startLocation = "start_location"
        case endLocation = "end_location"
    }
}

struct LocationPoint: Codable {
    let lat: Double
    let lng: Double
}
