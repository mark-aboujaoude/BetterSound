//
//  Player.swift
//  BetterSound
//
//  Created by Mark Abou-jaoude on 2025-06-06.
//

import Foundation


public class Player {
  /**
   We can add properties here depending
   on how we want the player to behave.
   */
}

extension Player {
  public enum State: Equatable, Hashable  {
    case playing
    case paused
    case stopped
//    case loading - Not used for demo purposes
//    case failed(Error) - Not used for demo purposes
  }
}
