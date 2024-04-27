import AVFoundation

class BgmPlayer {
    static let shared = BgmPlayer()
    private var audioPlayer: AVAudioPlayer?

    private init() {}

    func playBackgroundMusic(filename: String) {
        guard let path = Bundle.main.path(forResource: filename, ofType: "mp3") else {
            print("Failed to find the file path")
            return
        }

        let url = URL(fileURLWithPath: path)

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 // 無限にループさせる
            audioPlayer?.play()
        } catch {
            print("音楽ファイルの再生に失敗しました。")
        }
    }

    func stopBackgroundMusic() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
}
