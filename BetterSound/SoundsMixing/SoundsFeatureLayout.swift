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
  let store: StoreOf<SoundsFeature>

  var body: some View {
    ZStack {
      SoundsGridView(store: store)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.red)
        .onFirstAppear {
          store.send(.onFirstAppear)
        }
//      .alert($store.scope(state: \.alert, action: \.alert))

      VStack {
        Spacer()
        if !store.selectedSounds.isEmpty {
          SoundsPlayerView(
            playerState: store.playerState,
            selectedSounds: store.selectedSounds,
            onTapPlayPauseAction: { store.send(.playPauseButtonTapped) }
          )
          .padding(.horizontal)
        }
      }
    }
//    contentView
//      .frame(maxWidth: .infinity, maxHeight: .infinity)
//      .background(.black)
//      .onFirstAppear {
//        store.send(.onFirstAppear)
//      }
//      .alert($store.scope(state: \.alert, action: \.alert))
  }

  private var contentView: some View {
    VStack {
      Text("Demo time")
    }
  }
}
