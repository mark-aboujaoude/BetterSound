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
      ScrollView {
        Text("Sounds")
          .font(.title)
          .fontWeight(.bold)
          .foregroundColor(.white)

        SoundsGridView(store: store)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .padding(.horizontal)
          .onFirstAppear {
            store.send(.onFirstAppear)
          }
          .alert($store.scope(state: \.alert, action: \.alert))
      }
      .background(
        Image("Background2")
          .resizable()
          .scaledToFill()
          .ignoresSafeArea()
      )
      VStack {
        Spacer()
        if !store.selectedSounds.isEmpty {
          SoundsPlayerView(
            playerState: store.playerState,
            selectedSounds: store.selectedSounds,
            onTapPlayPauseAction: { store.send(.playPauseButtonTapped) },
            onTapClear: { store.send(.clearButtonTapped) }
          )
          .padding(.horizontal)
          .padding(.bottom)
        }
      }
    }
  }
}
