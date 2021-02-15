//
//  File.swift
//  
//
//  Created by Aji Saputra Raka Siwi on 15/02/21.
//

import Core
import RealmSwift

public struct FavoriteTransformer: Mapper {
  public typealias Request = Any
  public typealias Response = [Any]
  public typealias Entity = [FavoriteMovieEntity]
  public typealias Domain = [MovieModel]
  
  public func transformResponseToEntity(request: Any?, response: [Any]) -> [FavoriteMovieEntity] {
    return [FavoriteMovieEntity]()
  }
  
  public func transformEntityToDomain(entity: [FavoriteMovieEntity]) -> [MovieModel] {
    return entity.map { result in
      return MovieModel(
        id: result.id,
        title: result.title,
        overview: result.overview,
        posterPath: result.posterPath,
        releaseDate: result.releaseDate
      )
    }
  }
  
  public func transformResponseToDomain(response: [Any]) -> [MovieModel] {
    return [MovieModel]()
  }

  public func transformDomainToEntity(domain movieModel: MovieModel) -> FavoriteMovieEntity {
    let entity = FavoriteMovieEntity()
    entity.id = movieModel.id
    entity.title = movieModel.title
    entity.posterPath = movieModel.posterPath
    entity.overview = movieModel.overview
    entity.releaseDate = movieModel.releaseDate
    return entity
  }
  
}
