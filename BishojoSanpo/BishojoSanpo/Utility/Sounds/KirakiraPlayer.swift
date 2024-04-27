import AVFoundation

class KirakiraPlayer {
    static let shared = KirakiraPlayer()
    var audioPlayer: AVAudioPlayer?

    init() {
        setupAudioPlayer(soundName: "kirakirasound")
    }

    func setupAudioPlayer(soundName: String) {
        guard let path = Bundle.main.path(forResource: soundName, ofType: "mp3") else {
            print("Failed to find the file path")
            return
        }

        let url = URL(fileURLWithPath: path)

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
        } catch {
            print("Failed to initialize the audio player: \(error)")
        }
    }

    func playSound() {
        audioPlayer?.play()
    }
}
