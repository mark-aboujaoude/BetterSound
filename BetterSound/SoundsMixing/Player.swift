//
//  Player.swift
//  BetterSound
//
//  Created by Mark Abou-jaoude on 2025-06-06.
//

import Foundation


public class Player {

  /// The current playback state of the player, published for observers.
  @Published
  public private(set) var state: State = .stopped

  /// The current active stream. `nil` if no stream is active.
//  @Published
//  public private(set) var stream: Stream?
}

extension Player {
  public enum State: Equatable, Hashable  {
    case loading
    case playing
    case paused
    case stopped
//    case failed(Error)
  }

//  func toggle() {
//    self = (self == .playing) ? .paused : .playing
//  }
}
