//
//  MovieMapper.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 02/02/21.
//

import Foundation

final class MovieMapper {
  
  static func mapMovieResultResponsesToEntities(input movieResultResponses: [MovieResultResponse]) -> [MovieEntity] {
    return movieResultResponses.map { result in
      let entity = MovieEntity()
      entity.id = result.id
      entity.title = result.title ?? "Unknow"
      entity.posterPath = result.posterPath ?? ""
      entity.overview = result.overview ?? "No Overview Available"
      entity.releaseDate = result.releaseDate ?? ""
      return entity
    }
  }
  
  static func mapMovieEntitiesToDomains(input moviesEntities: [MovieEntity]) -> [MovieModel] {
    return moviesEntities.map { result in
      return MovieModel(
        id: result.id,
        title: result.title,
        overview: result.overview,
        posterPath: result.posterPath,
        releaseDate: result.releaseDate
      )
    }
  }
}
