//
//  File.swift
//  
//
//  Created by Aji Saputra Raka Siwi on 15/02/21.
//

import Foundation
import Combine
import Core

public final class FavoriteMovieRepository<
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

extension FavoriteMovieRepository: LocaleDataSource {
  public typealias Request = MovieModel
  public typealias Response = [MovieModel]
  
  public func getAllResponse() -> AnyPublisher<[MovieModel], Error> {
    return favoriteDataSource.getAllResponse().map {
      FavoriteTransformer().transformEntityToDomain(entity: $0)
    }
    .eraseToAnyPublisher()
  }
  
  public func getResponse(request: MovieModel) -> AnyPublisher<Bool, Error> {
    return self.favoriteDataSource.getResponse(request: request).map {_ in
      return true
    }
    .eraseToAnyPublisher()
  }
  
  public func addToLocale(request: MovieModel) -> AnyPublisher<Bool, Error> {
    return self.favoriteDataSource.addToLocale(request: request).eraseToAnyPublisher()
  }
  
  public func deleteFromLocale(request: MovieModel) -> AnyPublisher<Bool, Error> {
    return self.favoriteDataSource.deleteFromLocale(request: request).eraseToAnyPublisher()
  }

}
