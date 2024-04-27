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
    @State private var lastSerif: String? = nil //最後に表示されたセリフを記録
    var rank: Int
    
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
        let rankKey = String(rank)
        if let path = Bundle.main.path(forResource: "CharacterSerif", ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
           let serifsDict = try? JSONDecoder().decode([String: [String]].self, from: data),
           let serifs = serifsDict[rankKey], !serifs.isEmpty {
            var newSerifs = serifs.filter { $0 != lastSerif }
            if newSerifs.isEmpty { newSerifs = serifs }
            currentSerif = newSerifs.randomElement() ?? "No serifs found"
            lastSerif = currentSerif
        } else {
            currentSerif = "Error loading serifs or no serifs for this rank"
        }
        
    }
}


#Preview {
    SerifView(reload: true, rank: 7)
}
