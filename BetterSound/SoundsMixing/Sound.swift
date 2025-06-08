//
//  Sound.swift
//  BetterSound
//
//  Created by Mark Abou-jaoude on 2025-06-06.
//

import Foundation
import SwiftData

/**
 Used a class instead of struct to support the @Model macro
 */

@Model
class Sound: Equatable, Hashable, Decodable {
  @Attribute(.unique) var id: Int
  var name: String
  var audioName: String
  var selectedImageName: String
  var unselectedImageName: String
  // add support for tags - check filtering client

  init(
    id: Int,
    name: String,
    audioName: String,
    selectedImageName: String,
    unselectedImageName: String
  ) {
    self.id = id
    self.name = name
    self.audioName = audioName
    self.selectedImageName = selectedImageName
    self.unselectedImageName = unselectedImageName
  }

  required convenience init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    let id = try container.decode(Int.self, forKey: .id)
    let name = try container.decode(String.self, forKey: .name)
    let audioName = try container.decode(String.self, forKey: .audioName)
    let selectedImageName = try container.decode(String.self, forKey: .selectedImageName)
    let unselectedImageName = try container.decode(String.self, forKey: .unselectedImageName)

    self.init(
      id: id,
      name: name,
      audioName: audioName,
      selectedImageName: selectedImageName,
      unselectedImageName: unselectedImageName
    )
  }

  // CodingKeys is needed to match JSON keys with property names
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case audioName
    case selectedImageName
    case unselectedImageName
  }
}

extension Sound {
  static func == (lhs: Sound, rhs: Sound) -> Bool {
    lhs.id == rhs.id
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
