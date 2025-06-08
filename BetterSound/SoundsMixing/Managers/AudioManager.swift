//
//  SoundPlayer.swift
//  BetterSound
//
//  Created by Mark Abou-jaoude on 2025-06-07.
//

import AVFoundation

class AudioManager {
  private var players: [String: AVAudioPlayer] = [:]

  init() {
    try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
    try? AVAudioSession.sharedInstance().setActive(true)
  }

  func createPlayer(for fileName: String) {
    // If already playing, stop and remove
    if let existingPlayer = players[fileName] {
      existingPlayer.stop()
      players[fileName] = nil
    }

    guard let url = Bundle.main.url(forResource: fileName, withExtension: "caf") else {
      print("File not found: \(fileName).caf")
      return
    }

    do {
      let player = try AVAudioPlayer(contentsOf: url)
      player.prepareToPlay()
      players[fileName] = player
    } catch {
      print("Failed to play \(fileName): \(error)")
    }
  }

  func pause(named fileName: String) {
    players[fileName]?.pause()
  }

  func resume(named fileName: String) {
    players[fileName]?.play()
  }

  func stop(named fileName: String) {
    players[fileName]?.stop()
    players[fileName] = nil
  }

  func pauseAll() {
    for player in players.values {
      player.pause()
    }
  }

  func resumeAll() {
    for player in players.values {
      player.play()
    }
  }

  func stopAll() {
    for player in players.values {
      player.stop()
    }
    players.removeAll()
  }

  func isPlaying(_ fileName: String) -> Bool {
    players[fileName]?.isPlaying ?? false
  }
}
