//
//  SelectedSoundDataManagerTests.swift
//  BetterSoundTests
//
//  Created by Mark Aboujaoude on 2025-06-08.
//

import Testing
@testable import BetterSound

struct SelectedSoundDataManagerTests {
  let dataManager = SelectedSoundDataManager()

  @Test
  func storeAndFetchSound() {
    let sound = Sound(
      id: 1,
      name: "Rain",
      audioName: "rain.caf",
      selectedImageName: "rain_selected",
      unselectedImageName: "rain_unselected"
    )

    dataManager.store(sound: sound)
    let sounds = dataManager.fetchSounds()

    #expect(sounds.contains(sound))
  }

  @Test
  func removeSound() {
    let sound = Sound(id: 2, name: "Birds", audioName: "birds.caf", selectedImageName: "birds_selected", unselectedImageName: "birds_unselected")

    dataManager.store(sound: sound)
    #expect(dataManager.has(selected: sound))

    dataManager.remove(sound: sound)
    #expect(!dataManager.has(selected: sound))
  }


  @Test
  func removeAllSounds() {
    let sound1 = Sound(id: 3, name: "Wind", audioName: "wind.caf", selectedImageName: "wind_selected", unselectedImageName: "wind_unselected")
    let sound2 = Sound(id: 4, name: "Fire", audioName: "fire.caf", selectedImageName: "fire_selected", unselectedImageName: "fire_unselected")

    dataManager.store(sound: sound1)
    dataManager.store(sound: sound2)

    dataManager.removeAll()
    #expect(dataManager.fetchSounds().isEmpty)
  }

  @Test
  func hasSelectedSound() {
    let sound = Sound(id: 5, name: "Ocean", audioName: "ocean.caf", selectedImageName: "ocean_selected", unselectedImageName: "ocean_unselected")

    #expect(dataManager.has(selected: sound))
    dataManager.store(sound: sound)
    #expect(dataManager.has(selected: sound))
  }
}
