//
//  File.swift
//  
//
//  Created by Aji Saputra Raka Siwi on 15/02/21.
//

import Foundation

public struct MovieModel: Equatable, Identifiable {
  public let id: Int
  public let title: String
  public let overview: String
  public let posterPath: String
  public let releaseDate: String
  
  public init(id: Int, title: String, overview: String, posterPath: String, releaseDate: String) {
    self.id = id
    self.title = title
    self.overview = overview
    self.posterPath = posterPath
    self.releaseDate = releaseDate
  }
}
