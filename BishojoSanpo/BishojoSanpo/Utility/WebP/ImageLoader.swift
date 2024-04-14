//
//  ImageLoader.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/14.
//

import Foundation
import SwiftUI
import SDWebImageWebPCoder

struct ImageLoader {

    // WebP画像を読み込み、UIImageを返す静的メソッド
    static func loadWebPImage(from resourceName: String) -> UIImage? {
        // リソースファイルからのパスを取得
        guard let path = Bundle.main.path(forResource: resourceName, ofType: nil),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
              let image = SDImageWebPCoder.shared.decodedImage(with: data, options: nil) else {
            print("Failed to load or decode the WebP image")
            return nil
        }
        return image
    }
}
