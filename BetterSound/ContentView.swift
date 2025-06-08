//
//  ContentView.swift
//  BetterSound
//
//  Created by Mark Abou-jaoude on 2025-06-06.
//

import ComposableArchitecture
import SwiftUI

struct ContentView: View {
  @State private var hasAppeared = false
  @State private var showDemo = false

  var body: some View {
    VStack(spacing: 20) {
      Image(systemName: "airpods.max")
        .resizable()
        .frame(width: 100, height: 100)
        .foregroundStyle(.tint)

      Text("Welcome to **BetterSound**")

      Button("Proceed to demo") {
        showDemo = true
      }
      .padding()
      .background(Color.blue)
      .foregroundColor(.white)
      .cornerRadius(30)
    }
    .padding()
    .scaleEffect(hasAppeared ? 1 : 0.6)
    .opacity(hasAppeared ? 1 : 0)
    .animation(.spring(response: 0.5, dampingFraction: 0.6), value: hasAppeared)
    .onAppear {
      hasAppeared = true
    }
    .fullScreenCover(isPresented: $showDemo) {
      SoundsFeatureLayout(
        store: StoreOf<SoundsFeature>(initialState: .init()) {
          SoundsFeature(
            context: .init(retryButtonTitle: "", errorMessage: ""),
            selectedSoundManager: SelectedSoundDataManager(),
            audioManager: AudioManager()
          )
        }
      )
//      layout.store = StoreOf<SoundsFeature>(initialState: .init()) {
//        SoundsFeature(context: .init(retryButtonTitle: "", errorMessage: ""))
//      }
    }
  }
}

#Preview {
  ContentView()
}
