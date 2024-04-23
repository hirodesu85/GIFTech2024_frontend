//
//  WebPImageView.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/14.
//

import SwiftUI

struct WebPImageView: View {
    var imageName: String
    @State private var image: Image?

    var body: some View {
        Group {
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
            } else {
                Text("画像を読み込み中...")
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            loadImage()
        }
        .onChange(of: imageName) { newImageName in
            updateImage(imageName: newImageName)
        }
    }

    private func loadImage() {
        if let uiImage = ImageLoader.loadWebPImage(from: imageName) {
            image = Image(uiImage: uiImage)
        }
    }
    private func updateImage(imageName: String) {
        if let uiImage = ImageLoader.loadWebPImage(from: imageName) {
            image = Image(uiImage: uiImage)
        }
    }
}


#Preview {
    WebPImageView(imageName: "SampleWebP.webp")
}

