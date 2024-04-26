import AVFoundation

class AudioPlayer {
    static let shared = AudioPlayer()
    var audioPlayer: AVAudioPlayer?

    init() {
        setupAudioPlayer(soundName: "clicksound")
    }

    func setupAudioPlayer(soundName: String) {
        guard let path = Bundle.main.path(forResource: soundName, ofType: "mp3") else {
            print("Failed to find the file path")
            return
        }

        let url = URL(fileURLWithPath: path)  // この行はOptionalではない

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
