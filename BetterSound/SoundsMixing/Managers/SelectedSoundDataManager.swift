//
//  SelectedSoundDataManager.swift
//  BetterSound
//
//  Created by Mark Aboujaoude on 2025-06-07.
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
      // remove fatal error
      fatalError("Failed to set up ModelContainer: \(error)")
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

  func store(sound: Sound) {
    context.insert(sound)
    save()
  }

  func remove(sound: Sound) {
    guard let storedSound = fetchSounds().first(where: { $0.id == sound.id }) else {
      return
    }
    context.delete(storedSound)
    save()
  }

  func removeAll() {
    for sound in fetchSounds() {
      context.delete(sound)
    }
    save()
  }

  func has(selected sound: Sound) -> Bool {
    return fetchSounds().contains(sound)
  }
}

private extension SelectedSoundDataManager {
  func save() {
    do {
      try context.save()
    } catch {
      print("Failed to update stored sounds: \(error)")
    }
  }
}
