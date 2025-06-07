//
//  Sound.swift
//  BetterSound
//
//  Created by Mark Abou-jaoude on 2025-06-06.
//

import Foundation

struct Sound: Equatable, Hashable {
  let id: Int
  let name: String
  let audioName: String
  let selectedImageName: String
  let unselectedImageName: String
  let isSelected: Bool
  // add support for tags - check filtering client
}
