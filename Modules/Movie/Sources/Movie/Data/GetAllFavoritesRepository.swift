//
//  File.swift
//  
//
//  Created by Aji Saputra Raka Siwi on 16/02/21.
//

import Foundation
import Core
import Combine

public final class GetAllFavoritesRepository<
  LocaleFavoriteMovieDataSource: LocaleDataSource
> where
  LocaleFavoriteMovieDataSource.Request == MovieModel,
  LocaleFavoriteMovieDataSource.Response == [FavoriteMovieEntity]
{
  
  private let favoriteDataSource: LocaleFavoriteMovieDataSource
  
  public init(favoriteDataSource: LocaleFavoriteMovieDataSource) {
    self.favoriteDataSource = favoriteDataSource
  }
  
}

extension GetAllFavoritesRepository: Repository {
  public typealias Request = MovieModel
  public typealias Response = [MovieModel]
  
  public func execute(request: MovieModel?) -> AnyPublisher<[MovieModel], Error> {
    return favoriteDataSource.getAllResponse().map {
      FavoriteTransformer().transformEntityToDomain(entity: $0)
    }
    .eraseToAnyPublisher()
  }
  
}
