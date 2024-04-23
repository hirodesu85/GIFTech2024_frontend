//
//  SerifView.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/23.
//

import SwiftUI

struct SerifView: View {
    var reload: Bool
    @State private var currentSerif: String = "Loading..."
    @State private var lastSerif: String? = nil // 最後に表示されたセリフを記録
    
    var body: some View {
        ZStack {
            WebPImageView(imageName: "Home_Talk.webp")
            Text(currentSerif)
                .font(.custom("NotoSansJP-Black", size: 29))
                .foregroundColor(Color.nextRankTextShadow)
                .offset(y:18)
        }
        .onAppear(perform: loadRandomSerif)
        .onChange(of: reload) { _ in
            loadRandomSerif() // reloadが変わるたびにセリフを更新
        }
    }
    
    func loadRandomSerif() {
        if let path = Bundle.main.path(forResource: "BishojoSerif", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let serifs = try JSONDecoder().decode([String].self, from: data)
                if !serifs.isEmpty {
                    // 直前のセリフを除外してランダムに選択
                    var newSerifs = serifs.filter { $0 != lastSerif }
                    if newSerifs.isEmpty { // 万が一全てのセリフが同じ場合はフィルタリングをスキップ
                        newSerifs = serifs
                    }
                    currentSerif = newSerifs.randomElement() ?? "No serifs found"
                    lastSerif = currentSerif // 選択されたセリフを記録
                }
            } catch {
                currentSerif = "Error loading serifs"
                print(error)
            }
        }
    }
}


#Preview {
    SerifView(reload: true)
}
