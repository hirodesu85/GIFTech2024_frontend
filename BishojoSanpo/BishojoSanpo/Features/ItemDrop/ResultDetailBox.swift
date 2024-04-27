//
//  ResultDetailBox.swift
//  BishojoSanpo
//
//  Created by 吉野敬太郎 on 2024/04/27.
//

import SwiftUI

struct ResultDetailBox: View {
    let userDefaultsModel: UserDefaultsModel
    var body: some View {
        ZStack {
            WebPImageView(imageName: "Dialog_Back.webp")
            VStack {
                WebPImageView(imageName: "1Pittari_Text_Love.webp").aspectRatio(contentMode: .fit).frame(width: UIScreen.main.bounds.width * 0.45).padding(.bottom, 20).padding(.top, 24)
                RankView(rank: userDefaultsModel.rank).frame(width: UIScreen.main.bounds.width * 0.38)
                ZStack {
                    // 画像サイズ的に共有されたデザインが実装できないのでZStackで無理やり対応する
                    RankPointBarView(nowRankPoint: userDefaultsModel.currentRankPoint, nextRankPoint: userDefaultsModel.untilNextRank)
                    HStack {
                        Spacer()
                        Text("次のポイントまであと").foregroundColor(.white).font(.system(size: 14)).fontWeight(.black).stroke(color: Color.gray, width: 0.3)
                        Text("\(userDefaultsModel.untilNextRank)").foregroundColor(.white).font(.system(size: 22)).fontWeight(.black).baselineOffset(6).stroke(color: Color.gray, width: 0.3)
                    }.frame(alignment: .bottom).padding(.trailing, 10).padding(.bottom, 70)
                }
            }.frame(width: UIScreen.main.bounds.width * 0.71)
        }
    }
}

#Preview {
    ResultDetailBox(userDefaultsModel: UserDefaultsModel.shared)
}
