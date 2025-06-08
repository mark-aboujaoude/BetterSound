//
//  SoundsFeatureLayout.swift
//  BetterSound
//
//  Created by Mark Abou-jaoude on 2025-06-06.
//

import Foundation
import ComposableArchitecture
import SwiftUI

struct SoundsFeatureLayout: View {
  @Bindable var store: StoreOf<SoundsFeature>

  var body: some View {
    ZStack {
//      Image("Background")
//        .resizable()
//        .scaledToFill()
//        .ignoresSafeArea()
      // Using Image("Background") directly removes padding
      Color.clear.background(
        Image("Background")
          .resizable()
          .scaledToFill()
          .ignoresSafeArea()
      )

      SoundsGridView(store: store)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal)
        .onFirstAppear {
          store.send(.onFirstAppear)
        }
        .alert($store.scope(state: \.alert, action: \.alert))

      VStack {
        Spacer()
        if !store.selectedSounds.isEmpty {
          SoundsPlayerView(
            playerState: store.playerState,
            selectedSounds: store.selectedSounds,
            onTapPlayPauseAction: { store.send(.playPauseButtonTapped) }
          )
          .padding(.horizontal)
          .padding(.bottom)
        }
      }
    }
  }
}
