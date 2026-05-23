//
//  ThemeAmbiencePlayer.swift
//  Tight Rope Car
//

import AVFoundation
import Combine
import Foundation

/// Loops bundled theme ambience clips referenced by ``BackgroundThemeMetadata/ambienceSoundName``.
@MainActor
final class ThemeAmbiencePlayer: ObservableObject {
    @Published private(set) var playingSoundName: String?

    private var audioPlayer: AVAudioPlayer?

    nonisolated static func bundleURL(for soundName: String) -> URL? {
        BundledAudioLocator.url(forResource: soundName)
    }

    nonisolated static func isSoundAvailable(_ soundName: String) -> Bool {
        BundledAudioLocator.isAvailable(soundName)
    }

    var isPlaying: Bool {
        audioPlayer?.isPlaying == true
    }

    func isPlaying(soundName: String) -> Bool {
        playingSoundName == soundName && isPlaying
    }

    func play(soundName: String) {
        guard let url = Self.bundleURL(for: soundName) else { return }

        stop()

        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.ambient, mode: .default, options: [.mixWithOthers])
            try session.setActive(true)

            let player = try AVAudioPlayer(contentsOf: url)
            player.numberOfLoops = -1
            player.volume = 0.5
            player.prepareToPlay()
            player.play()
            audioPlayer = player
            playingSoundName = soundName
        } catch {
            audioPlayer = nil
            playingSoundName = nil
        }
    }

    func stop() {
        audioPlayer?.stop()
        audioPlayer = nil
        playingSoundName = nil
    }

    func toggle(soundName: String) {
        if isPlaying(soundName: soundName) {
            stop()
        } else {
            play(soundName: soundName)
        }
    }
}
