//
//  LocationManager.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/16.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var location: CLLocation?
    private let locationManager = CLLocationManager()
    var onLocationUpdate: ((CLLocation) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // アプリ使用中の位置情報取得の許可を要求
    }
    
    // 位置情報を一度だけ取得
    func fetchLocation() {
        locationManager.requestLocation()
    }
    
    // 位置情報の連続取得を開始
    func startUpdatingLocation() {
        //        isUpdateLocation = false
        locationManager.startUpdatingLocation()
    }
    
    // 位置情報の取得を停止
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.first {
            location = newLocation
            onLocationUpdate?(newLocation) // 新しい位置情報をクロージャで通知
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
        if (error as NSError).code == 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // 0.1秒後に再試行
                self.fetchLocation()
            }
        }
    }
}


