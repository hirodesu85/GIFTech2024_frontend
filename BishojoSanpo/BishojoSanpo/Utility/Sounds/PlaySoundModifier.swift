import SwiftUI
import AVFoundation

struct PlaySoundModifier: ViewModifier {
    var soundName: String
    var audioPlayer: AVAudioPlayer?

    init(soundName: String) {
        self.soundName = soundName
        print("Looking for sound in bundle path: \(Bundle.main.bundlePath)")
        if let path = Bundle.main.path(forResource: soundName, ofType: nil) {
            print("File path found: \(path)")
            do {
                let url = URL(fileURLWithPath: path)
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.prepareToPlay()
            } catch {
                print("Error occurred: \(error)")
            }
        } else {
            print("Failed to find the file path for \(soundName)")
        }
    }

    func body(content: Content) -> some View {
        content
            .onTapGesture {
                audioPlayer?.play()
            }
    }
}

extension View {
    func playSound(named soundName: String) -> some View {
        self.modifier(PlaySoundModifier(soundName: soundName))
    }
}
