//
//  SoundsFeature.swift
//  BetterSound
//
//  Created by Mark Aboujaoude on 2025-06-06.
//

import ComposableArchitecture
import Foundation

@Reducer
struct SoundsFeature {
  struct Context {
    var alertTitle: String
    var alertMessage: String
    var alertButton: String
  }

  @ObservableState
  struct State: Equatable, Hashable {
    var selectedSounds: Set<Sound> = []
    var sounds: [Sound] = []
    var playerState: Player.State = .stopped

    @Presents var alert: AlertState<Action.Alert>?
  }

  enum Action: Equatable {
    // User Actions
    case onFirstAppear
    case add(Sound)
    case remove(Sound)
    case playPauseButtonTapped
    case clearButtonTapped
    case alert(PresentationAction<Alert>)

    // Internal Actions
    case loaded([Sound], Set<Sound>)

    @CasePathable
    enum Alert: Equatable, Hashable {}
  }

  private let context: Context
  private let selectedSoundManager: SelectedSoundDataManager
  private var audioManager: AudioManager

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onFirstAppear:
        return .run { send in
          await send(.loaded(loadMockData(), selectedSoundManager.fetchSounds()))
        }

      case .loaded(let sounds, let selectedSounds):
        state.sounds = sounds
        state.selectedSounds = selectedSounds
        for sound in state.selectedSounds {
          audioManager.createPlayer(for: sound.audioName)
        }
        return .none

      case let .add(sound):
        guard state.selectedSounds.count < 3 else {
          state.alert = AlertState {
            TextState(context.alertTitle)
          } actions: {
            ButtonState(role: .cancel) {
              TextState(context.alertButton)
            }
          } message: {
            TextState(context.alertMessage)
          }
          return .none
        }
        selectedSoundManager.store(sound: sound)
        state.selectedSounds = selectedSoundManager.fetchSounds()
        state.playerState = .playing
        audioManager.createPlayer(for: sound.audioName)
        audioManager.resumeAll()
        return .none

      case let .remove(sound):
        selectedSoundManager.remove(sound: sound)
        state.selectedSounds = selectedSoundManager.fetchSounds()
        audioManager.stop(named: sound.audioName)
        if state.selectedSounds.isEmpty {
          state.playerState = .paused
        }
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

      case .clearButtonTapped:
        selectedSoundManager.removeAll()
        state.selectedSounds = selectedSoundManager.fetchSounds()
        audioManager.stopAll()
        state.playerState = .stopped
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
