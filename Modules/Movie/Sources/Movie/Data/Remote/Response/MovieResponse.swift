//
//  File.swift
//  
//
//  Created by Aji Saputra Raka Siwi on 15/02/21.
//

import Foundation

public struct MoviesResponse: Decodable {
  public let movies: [MovieResultResponse]
  
  private enum CodingKeys: String, CodingKey {
    case movies = "results"
  }
  
}

public struct MovieResultResponse: Decodable {

  private enum CodingKeys: String, CodingKey {
    case id, title, overview
    case posterPath = "poster_path"
    case releaseDate = "release_date"
  }

  public let id: Int
  public let title: String?
  public let overview: String?
  public let posterPath: String?
  public let releaseDate: String?
}
