//
//  File.swift
//  
//
//  Created by Aji Saputra Raka Siwi on 15/02/21.
//

import Foundation
import RealmSwift

public class FavoriteMovieEntity: Object {
  @objc public dynamic var id: Int = 0
  @objc public dynamic var title: String = ""
  @objc public dynamic var posterPath: String = ""
  @objc public dynamic var overview: String = ""
  @objc public dynamic var releaseDate: String = ""

  override public static func primaryKey() -> String? {
    return "id"
  }
}
