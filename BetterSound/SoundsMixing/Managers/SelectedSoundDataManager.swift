//
//  SelectedSoundDataManager.swift
//  BetterSound
//
//  Created by Mark Abou-jaoude on 2025-06-07.
//

import Foundation
import SwiftData

class SelectedSoundDataManager {
  private let modelContainer: ModelContainer
  private var context: ModelContext

  init() {
    do {
      modelContainer = try ModelContainer(for: Sound.self)
      context = ModelContext(modelContainer)
    } catch {
      fatalError("Failed to set up ModelContainer: \(error)") // remove fatal error
    }
  }

  func store(sound: Sound) {
    context.insert(sound)

    do {
      try context.save()
    } catch {
      print("Failed to save sound: \(error)")
    }
  }

  func fetchSounds() -> Set<Sound> {
    let descriptor = FetchDescriptor<Sound>()
    do {
      return try Set(context.fetch(descriptor))
    } catch {
      print("Failed to fetch sounds: \(error)")
      return []
    }
  }

  func remove(sound: Sound) {
    guard let storedSound = fetchSounds().first(where: { $0.id == sound.id }) else {
      return
    }
    context.delete(storedSound)
    do {
      try context.save()
    } catch {
      print("Failed to delete sound: \(error)")
    }
  }

//  func remove(sound: Sound) {
//    print("B E F O R E")
//    print(fetchSounds().map { $0.id })
//    print("A F T E R")
//    context.delete(sound)
//    print(fetchSounds().map { $0.id })
//    do {
//      try context.save()
//    } catch {
//      print("Failed to delete sound: \(error)")
//    }
//  }

  func has(selected sound: Sound) -> Bool {
    return fetchSounds().contains(sound)
  }
}
