//
//  MovieMapper.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 02/02/21.
//

import Foundation
import Movie

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
  
  static func mapMovieResultResponseToDomains(input moviesResponses: [MovieResultResponse]) -> [MovieModel] {
    return moviesResponses.map { result in
      return MovieModel(
        id: result.id,
        title: result.title ?? "",
        overview: result.overview ?? "",
        posterPath: result.posterPath ?? "",
        releaseDate: result.releaseDate ?? ""
      )
    }
  }
  
  static func mapDomainToMovieFavoriteEntity(input movieModel: MovieModel) -> FavoriteMovieEntity {
    let entity = FavoriteMovieEntity()
    entity.id = movieModel.id
    entity.title = movieModel.title
    entity.posterPath = movieModel.posterPath
    entity.overview = movieModel.overview
    entity.releaseDate = movieModel.releaseDate
    return entity
  }
  
//  static func mapMovieFavoriteEntityToDomainz(input favoriteEntity: FavoriteMovieEntity) -> MovieModel {
//    return MovieModel(
//      id: favoriteEntity.id,
//      title: favoriteEntity.title,
//      overview: favoriteEntity.overview,
//      posterPath: favoriteEntity.posterPath,
//      releaseDate: favoriteEntity.releaseDate
//    )
//  }
  
  static func mapMovieFavoritesEntityToDomains(input favoriteEntities: [FavoriteMovieEntity]) -> [MovieModel] {
    return favoriteEntities.map { entity in
      return MovieModel(
        id: entity.id,
        title: entity.title,
        overview: entity.overview,
        posterPath: entity.posterPath,
        releaseDate: entity.releaseDate
      )
    }
  }
}
