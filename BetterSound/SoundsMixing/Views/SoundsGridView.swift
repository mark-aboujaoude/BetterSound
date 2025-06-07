//
//  SoundsGridView.swift
//  BetterSound
//
//  Created by Mark Abou-jaoude on 2025-06-07.
//

import ComposableArchitecture
import SwiftUI

struct SoundsGridView: View {
//  let sounds: [Sound]
  let store: StoreOf<SoundsFeature>

  let columns = [
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible())
  ]

  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns, spacing: 16) {
        ForEach(store.sounds, id: \.self) { sound in
          SelectableSoundView(sound: sound) {
            store.send(sound.isSelected ? .remove(sound) : .add(sound))
            print("Tapped on sound \(sound)")
          }
        }
      }
      .padding()
    }
  }
}

struct SelectableSoundView: View {
  let sound: Sound
  let onTap: () -> Void

  var body: some View {
    VStack(spacing: 8) {
      Button(action: onTap) {
        Image(imageName)
          .resizable()
          .scaledToFill()
          .frame(height: 100)
          .frame(maxWidth: .infinity)
          .clipped()
          .cornerRadius(12)
      }

      Text(sound.name)
        .font(.caption)
        .multilineTextAlignment(.center)
    }
  }

  private var imageName: String {
    sound.isSelected ? sound.selectedImageName : sound.unselectedImageName
  }
}
