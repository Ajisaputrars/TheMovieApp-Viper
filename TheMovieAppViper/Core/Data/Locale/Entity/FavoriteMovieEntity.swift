//
//  FavoriteMovieEntity.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 04/02/21.
//

import Foundation
import RealmSwift

class FavoriteMovieEntity: Object {
  @objc dynamic var id: Int = 0
  @objc dynamic var title: String = ""
  @objc dynamic var posterPath: String = ""
  @objc dynamic var overview: String = ""
  @objc dynamic var releaseDate: String = ""

  override static func primaryKey() -> String? {
    return "id"
  }
}
