//
//  Sound.swift
//  BetterSound
//
//  Created by Mark Aboujaoude on 2025-06-06.
//

import Foundation
import SwiftData

/**
 `@Model` only supports classes - not structs
 `@Model` requires an initializer be provided for `Sound`
  This requires the decoder init as a result.
 */
@Model
class Sound: Decodable {
  @Attribute(.unique) var id: Int
  var name: String
  var audioName: String
  var selectedImageName: String
  var unselectedImageName: String
  // Tag IDs - Not supported for demo

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

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case audioName
    case selectedImageName
    case unselectedImageName
  }
}

extension Sound: Equatable, Hashable {
  static func == (lhs: Sound, rhs: Sound) -> Bool {
    lhs.id == rhs.id
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
