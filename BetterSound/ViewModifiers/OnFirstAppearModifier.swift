//
//  OnFirstAppearModifier.swift
//  BetterSound
//
//  Created by Mark Abou-jaoude on 2025-06-06.
//

import SwiftUI

struct OnFirstAppearModifier: ViewModifier {
  @State private var didAlreadyAppear = false
  private let action: () -> Void

  init(perform action: @escaping () -> Void) {
    self.action = action
  }

  func body(content: Content) -> some View {
    content.onAppear {
      guard !didAlreadyAppear else { return }
      didAlreadyAppear.toggle()
      action()
    }
  }
}

public extension View {
  func onFirstAppear(perform action: @escaping () -> Void) -> some View {
    modifier(OnFirstAppearModifier(perform: action))
  }
}
