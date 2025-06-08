//
//  SoundsGridView.swift
//  BetterSound
//
//  Created by Mark Abou-jaoude on 2025-06-07.
//

import ComposableArchitecture
import SwiftUI

struct SoundsGridView: View {
  let store: StoreOf<SoundsFeature>

  let columns = [
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible())
  ]

  var body: some View {
    LazyVGrid(columns: columns, spacing: 16) {
      ForEach(store.sounds, id: \.self) { sound in
        let isSelected = store.selectedSounds.contains(sound)
        SelectableSoundView(
          sound: sound,
          isSelected: isSelected,
          playerState: store.playerState
        ) {
          store.send(isSelected ? .remove(sound) : .add(sound))
        }
      }
    }
    .padding()
  }
}
