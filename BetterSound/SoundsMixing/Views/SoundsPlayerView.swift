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
  let onTapClear: () -> Void

  var body: some View {
      HStack(spacing: 16) {
        Button(action: onTapClear) {
          Image(systemName: "xmark")
            .resizable()
            .scaledToFit()
            .frame(width: 18, height: 18)
            .padding(3)
            .foregroundColor(.white)
        }

        HStack(spacing: -20) {
          ForEach(Array(selectedSounds.prefix(3)), id: \.id) { sound in
            Image(sound.unselectedImageName)
              .resizable()
              .scaledToFill()
              .frame(width: 45, height: 45)
              .clipShape(RoundedRectangle(cornerRadius: 10))
          }
        }
        .padding(.vertical, 8)

        Text(selectedSounds.map(\.name).joined(separator: " & "))
          .font(.caption)
          .foregroundColor(.white)

        Spacer()

        Button(action: onTapPlayPauseAction) {
          Image(systemName: playerState == .playing ? "pause.fill" : "play.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 18, height: 18)
            .padding(3)
            .foregroundColor(.white)
        }
      }
      .frame(height: 70)
      .padding(.horizontal, 24)
      .background(
        LinearGradient(
          gradient: Gradient(
            colors: [.white.opacity(0.1), .gray.opacity(0.4), .black.opacity(0.2)]
          ),
          startPoint: .leading,
          endPoint: .trailing
        )
      )
      .cornerRadius(16)
//      .accessibilityElement(children: .ignore)
//      .accessibilityLabel(accessibility)
//      .accessibilityAction { onTapPlayPauseAction() }
  }
}
