//
//  SelectableSoundView.swift
//  BetterSound
//
//  Created by Mark Abou-jaoude on 2025-06-08.
//

import SwiftUI

struct SelectableSoundView: View {
  let sound: Sound
  let isSelected: Bool
  let playerState: Player.State
  let onTap: () -> Void

  @State private var rotationAngle: Double = 0
  @State private var timer: Timer?

  var body: some View {
    VStack(spacing: 0) {
      Button(action: onTap) {
        Image(imageName)
          .resizable()
          .scaledToFill()
          .frame(height: 100)
          .frame(maxWidth: .infinity)
          .clipped()
          .cornerRadius(12)
          .rotationEffect(.degrees(shouldAnimate ? rotationAngle : 0))
          .onAppear {
            if shouldAnimate {
              startSwinging()
            }
          }
          .onChange(of: shouldAnimate) { _, newValue in
            if newValue {
              startSwinging()
            } else {
              stopSwinging()
            }
          }
      }

      Text(sound.name)
        .font(.caption)
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
    }
  }

  private var imageName: String {
    isSelected ? sound.selectedImageName : sound.unselectedImageName
  }

  private var shouldAnimate: Bool {
    playerState == .playing && isSelected
  }

  private func startSwinging() {
    stopSwinging() // Invalidate old timer first
    var direction = 1.0
    timer = .scheduledTimer(withTimeInterval: 0.7, repeats: true) { _ in
      withAnimation {
        rotationAngle = direction * 5
        direction *= -1
      }
    }
  }

  private func stopSwinging() {
    timer?.invalidate()
    timer = nil
    withAnimation {
      rotationAngle = 0
    }
  }
}
