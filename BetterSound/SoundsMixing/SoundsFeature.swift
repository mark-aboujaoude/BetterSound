//
//  SoundsFeature.swift
//  BetterSound
//
//  Created by Mark Abou-jaoude on 2025-06-06.
//

import AVFoundation
import ComposableArchitecture
import Foundation
import IdentifiedCollections
import SwiftData

@Reducer
struct SoundsFeature {
  struct Context {
    var retryButtonTitle: String
    var errorMessage: String
  }

  @ObservableState
  struct State: Equatable, Hashable {
    var selectedSounds: Set<Sound> = []
    var sounds: [Sound] = []
    var playerState: Player.State = .stopped
    var mode: Mode = .loading

    @Presents var alert: AlertState<Action.Alert>?
  }

  enum Action: Equatable {
    // User Actions
    case onFirstAppear
    case retryButtonTapped
    case add(Sound)
    case remove(Sound)
    case playPauseButtonTapped
    case alert(PresentationAction<Alert>)

    // Internal Actions
//    case receivedPlayerState(Player.State)
    case connectionFailed
    case connectionSucceed([Sound])

    @CasePathable
    enum Alert: Equatable, Hashable {}
  }

  private let context: Context
  private let selectedSoundManager: SelectedSoundDataManager
  private var audioManager: AudioManager

  private let featureId = UUID()

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onFirstAppear:
        state.sounds = loadMockData()
        state.selectedSounds = selectedSoundManager.fetchSounds()
        for sound in state.selectedSounds {
          audioManager.createPlayer(for: sound.audioName)
        }
//        return connectAndListen()
        return .none

        // probably don't need this
      case .connectionSucceed(let sounds):
        state.mode = .displaySounds
        return .none

      case .connectionFailed:
        state.mode = .retry(message: context.errorMessage, buttonTitle: context.retryButtonTitle)
        return .none

      case .retryButtonTapped:
//        return connect()
        return .none

      case let .add(sound):
        guard state.selectedSounds.count < 3 else {
          state.alert = AlertState {
            TextState("Hi There!")
          } actions: {
            ButtonState(role: .cancel) {
              TextState("OK")
            }
          } message: {
            TextState("Become a premium member to use more than 3.")
          }
          return .none
        }
        selectedSoundManager.store(sound: sound)
        state.selectedSounds = selectedSoundManager.fetchSounds()
        state.playerState = .playing
        audioManager.createPlayer(for: sound.audioName)
        audioManager.resumeAll()
        // need to cap it at 3 and show an alert
        return .none

      case let .remove(sound):
        selectedSoundManager.remove(sound: sound)
        state.selectedSounds = selectedSoundManager.fetchSounds()
        audioManager.stop(named: sound.audioName)
        return .none

      case .playPauseButtonTapped:
        state.playerState = state.playerState == .playing ? .paused : .playing
        switch state.playerState {
        case .playing:
          audioManager.resumeAll()
        case .paused:
          audioManager.pauseAll()
        default: break
        }
        return .none

      case .alert:
        state.alert = nil
        return .none
      }
    }
  }

  init(
    context: Context,
    selectedSoundManager: SelectedSoundDataManager,
    audioManager: AudioManager
  ) {
    self.context = context
    self.selectedSoundManager = selectedSoundManager
    self.audioManager = audioManager
  }
}

extension SoundsFeature {
  enum Mode: Equatable, Hashable {
    case loading
    case retry(message: String, buttonTitle: String)
    case displaySounds
  }
}

// MARK: Process content
private extension SoundsFeature {
  func loadMockData() -> [Sound] {
    guard
      let url = Bundle.main.url(forResource: "sounds", withExtension: "json"),
      let data = try? Data(contentsOf: url)
    else {
      print("Could not find or load sounds.json")
      return []
    }

    do {
      return try JSONDecoder().decode([Sound].self, from: data)
    } catch {
      print("Failed to decode JSON: \(error)")
      return []
    }
  }
}
