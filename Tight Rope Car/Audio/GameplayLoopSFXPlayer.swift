//
//  GameplayLoopSFXPlayer.swift
//  Tight Rope Car
//

import AVFoundation
import Combine
import Foundation

/// Loops gameplay-only clips during active runs (`engine_loop`). Theme ambience uses ``ThemeAmbiencePlayer``.
@MainActor
final class GameplayLoopSFXPlayer: ObservableObject {
    static let engineSoundName = "engine_loop"

    private static let engineVolumeNormal: Float = 0.42
    private static let engineVolumeDucked: Float = 0.30

    @Published private(set) var isEnginePlaying = false

    private var audioPlayer: AVAudioPlayer?
    private var duckedForThemeAmbience = false

    nonisolated static func isClipAvailable(_ soundName: String = engineSoundName) -> Bool {
        BundledAudioLocator.isAvailable(soundName)
    }

    var isPlaying: Bool {
        audioPlayer?.isPlaying == true
    }

    /// Starts or maintains the engine loop; lowers volume when theme ambience is also playing.
    func playEngine(duckedForThemeAmbience: Bool) {
        guard Self.isClipAvailable() else { return }

        if isPlaying, duckedForThemeAmbience == self.duckedForThemeAmbience {
            return
        }

        let targetVolume = duckedForThemeAmbience ? Self.engineVolumeDucked : Self.engineVolumeNormal

        if isPlaying {
            self.duckedForThemeAmbience = duckedForThemeAmbience
            audioPlayer?.volume = targetVolume
            return
        }

        guard let url = BundledAudioLocator.url(forResource: Self.engineSoundName) else { return }

        stop()

        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.ambient, mode: .default, options: [.mixWithOthers])
            try session.setActive(true)

            let player = try AVAudioPlayer(contentsOf: url)
            player.numberOfLoops = -1
            player.volume = targetVolume
            player.prepareToPlay()
            player.play()
            audioPlayer = player
            self.duckedForThemeAmbience = duckedForThemeAmbience
            isEnginePlaying = true
        } catch {
            audioPlayer = nil
            isEnginePlaying = false
        }
    }

    func stop() {
        audioPlayer?.stop()
        audioPlayer = nil
        duckedForThemeAmbience = false
        isEnginePlaying = false
    }
}
