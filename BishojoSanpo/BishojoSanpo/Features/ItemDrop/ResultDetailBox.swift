//
//  ResultDetailBox.swift
//  BishojoSanpo
//
//  Created by 吉野敬太郎 on 2024/04/27.
//

import SwiftUI

struct ResultDetailBox: View {
    @ObservedObject var userDefaultsModel = UserDefaultsModel()
    let rank: Int
    let untilNextRank: Int
    var body: some View {
        ZStack {
            WebPImageView(imageName: "Dialog_Back.webp")
            VStack {
                WebPImageView(imageName: "1Pittari_Text_Love.webp").aspectRatio(contentMode: .fit).frame(width: UIScreen.main.bounds.width * 0.45).padding(.bottom, 20).padding(.top, 24)
                RankView(rank: rank).frame(width: UIScreen.main.bounds.width * 0.38)
                ZStack {
                    // 画像サイズ的に共有されたデザインが実装できないのでZStackで無理やり対応する
                    RankPointBarView(nowRankPoint: calcNowRankPoint(rank: rank, untilNextRank: untilNextRank), nextRankPoint: untilNextRank)
                    HStack {
                        Spacer()
                        Text("次のポイントまであと").foregroundColor(.white).font(.system(size: 14)).fontWeight(.black).stroke(color: Color.gray, width: 0.3)
                        Text("\(untilNextRank)").foregroundColor(.white).font(.system(size: 22)).fontWeight(.black).baselineOffset(6).stroke(color: Color.gray, width: 0.3)
                    }.frame(alignment: .bottom).padding(.trailing, 10).padding(.bottom, 70)
                }
            }.frame(width: UIScreen.main.bounds.width * 0.71)
        }
    }
    // 前回のランクのMAXまでの通算ポイントを除いた現在のポイントを返す
    // 実際は7 ~ 8しか使われないが、それ以外も実装した(特に理由はない)
    private func calcNowRankPoint(rank: Int, untilNextRank: Int) -> Int {
        switch rank {
        case 1:
            return 100 - untilNextRank
        case 2:
            return 200 - untilNextRank
        case 3:
            return 300 - untilNextRank
        case 4:
            return 400 - untilNextRank
        case 5:
            return 500 - untilNextRank
        case 6:
            return 600 - untilNextRank
        case 7:
            return 700 - untilNextRank
        case 8:
            return 800 - untilNextRank
        case 9:
            return 900 - untilNextRank
        default:
            // ここが実行されることはあり得ないが、XCodに怒られるし、例外を考えるのは面倒臭いのでデカい値を返す
            return 10000
        }
    }
}

#Preview {
    ResultDetailBox(rank: 8, untilNextRank: 700)
}
