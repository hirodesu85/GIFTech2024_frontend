//
//  BishojoSanpoApp.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/04.
//

import SwiftUI
import GoogleMaps

@main
struct BishojoSanpoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}

// アプリ起動時に一回行う処理
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        GMSServices.provideAPIKey(Constants.apiKey)
        
        return true
    }
}
