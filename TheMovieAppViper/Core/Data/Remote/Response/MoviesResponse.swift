//
//  MovieResponse.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 02/02/21.
//

import Foundation

struct MoviesResponse: Decodable {
  let movies: [MovieResultResponse]
  
  private enum CodingKeys: String, CodingKey {
    case movies = "results"
  }
  
}

struct MovieResultResponse: Decodable {

  private enum CodingKeys: String, CodingKey {
    case id, title, overview
    case posterPath = "poster_path"
    case releaseDate = "release_date"
  }

  let id: Int
  let title: String?
  let overview: String?
  let posterPath: String?
  let releaseDate: String?
}
