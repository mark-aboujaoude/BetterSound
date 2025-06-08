//
//  SoundsPlayerView.swift
//  BetterSound
//
//  Created by Mark Abou-jaoude on 2025-06-07.
//

import ComposableArchitecture
import SwiftUI

struct SoundsPlayerView: View {
  let playerState: Player.State
  let selectedSounds: Set<Sound>
  let onTapPlayPauseAction: () -> Void

  @State private var image = UIImage()

  var body: some View {
      HStack(spacing: 16) {
        Image(uiImage: image)
          .resizable()
          .scaledToFill()
          .frame(width: 36, height: 36)
          .clipShape(RoundedRectangle(cornerRadius: 10))
          .padding(.vertical, 8)

        Text(selectedSounds.map(\.name).joined(separator: " & "))
          .foregroundColor(.white)

        Spacer()

        Button(action: onTapPlayPauseAction) {
          Image(systemName: playerState == .playing ? "pause.fill" : "play.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 18, height: 18)
            .padding(3)
        }
      }
      .frame(height: 70)
      .padding(.horizontal, 24)
      .background(Color.black.opacity(0.5))
      .cornerRadius(16)
//      .accessibilityElement(children: .ignore)
//      .accessibilityLabel(accessibility)
//      .accessibilityAction { onTapPlayPauseAction() }
  }
}
