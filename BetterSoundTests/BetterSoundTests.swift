//
//  BetterSoundTests.swift
//  BetterSoundTests
//
//  Created by Mark Aboujaoude on 2025-06-06.
//

import ComposableArchitecture
import Foundation
import Testing
@testable import BetterSound

struct BetterSoundTests {
  let dataManager = SelectedSoundDataManager()

  @Test
  func onAppearAndLoaded() async {
    let mockSounds = loadMockData()
    dataManager.removeAll()
    let store = await TestStore(initialState: .init()) {
      SoundsFeature.init(
        context: .init(alertTitle: "UT_title", alertMessage: "UT_message", alertButton: "UT_button"),
        selectedSoundManager: dataManager,
        audioManager: AudioManager()
      )
    }

    // When feature is shown
    await store.send(.onFirstAppear)
    await store.receive(.loaded(mockSounds, [])) {
      $0.sounds = mockSounds
      $0.selectedSounds = []
    }
    await store.finish()
  }

  @Test
  func addAndRemove() async {
    let mockSounds = loadMockData()
    guard let mockSound = mockSounds.first else { return }
    dataManager.removeAll()
    let store = await TestStore(initialState: .init()) {
      SoundsFeature.init(
        context: .init(alertTitle: "UT_title", alertMessage: "UT_message", alertButton: "UT_button"),
        selectedSoundManager: dataManager,
        audioManager: AudioManager()
      )
    }

    // When feature is shown
    await store.send(.onFirstAppear)
    await store.receive(.loaded(mockSounds, [])) {
      $0.sounds = mockSounds
      $0.selectedSounds = []
    }

    // When sound is selected
    await store.send(.add(mockSound)) {
      $0.selectedSounds = [mockSound]
      $0.playerState = .playing
    }

    // when sound is removed
    await store.send(.remove(mockSound)) {
      $0.selectedSounds = []
      $0.playerState = .paused
    }

    await store.finish()
  }
}

private extension BetterSoundTests {
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
