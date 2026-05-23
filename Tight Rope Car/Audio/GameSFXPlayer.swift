//
//  GameSFXPlayer.swift
//  Tight Rope Car
//

import AVFoundation
import Foundation

/// Plays short gameplay SFX without blocking the SpriteKit loop (README v0.2).
@MainActor
final class GameSFXPlayer {
    static let shared = GameSFXPlayer()

    private var activePlayers: [AVAudioPlayer] = []
    private let delegates = NSHashTable<OneShotAudioDelegate>.weakObjects()

    private init() {}

    var isEnabled = true

    func play(_ sfx: GameSFX, volume: Float = 1) {
        play(soundName: sfx.rawValue, volume: volume)
    }

    func play(soundName: String, volume: Float = 1) {
        guard isEnabled, let url = BundledAudioLocator.url(forResource: soundName) else { return }

        do {
            try configureSessionForSFX()
            let player = try AVAudioPlayer(contentsOf: url)
            player.volume = volume
            player.prepareToPlay()

            let delegate = OneShotAudioDelegate { [weak self] finishedPlayer in
                self?.remove(player: finishedPlayer)
            }
            player.delegate = delegate
            delegates.add(delegate)
            activePlayers.append(player)
            player.play()
        } catch {
            // Missing or corrupt clip — gameplay continues silently.
        }
    }

    func stopAll() {
        for player in activePlayers {
            player.stop()
        }
        activePlayers.removeAll()
    }

    // MARK: - Private

    private func configureSessionForSFX() throws {
        let session = AVAudioSession.sharedInstance()
        try session.setCategory(.ambient, mode: .default, options: [.mixWithOthers])
        try session.setActive(true)
    }

    private func remove(player: AVAudioPlayer) {
        activePlayers.removeAll { $0 === player }
    }
}

// MARK: - Delegate

private final class OneShotAudioDelegate: NSObject, AVAudioPlayerDelegate {
    private let onFinish: (AVAudioPlayer) -> Void

    init(onFinish: @escaping (AVAudioPlayer) -> Void) {
        self.onFinish = onFinish
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        onFinish(player)
    }
}
