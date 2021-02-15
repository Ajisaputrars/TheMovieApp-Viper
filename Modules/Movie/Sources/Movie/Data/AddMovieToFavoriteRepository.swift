//
//  File.swift
//  
//
//  Created by Aji Saputra Raka Siwi on 16/02/21.
//

import Foundation
import Core
import Combine

public final class AddMovieToFavoriteRepository<
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

extension AddMovieToFavoriteRepository: Repository {
  public typealias Request = MovieModel
  public typealias Response = Bool
  
  public func execute(request: MovieModel?) -> AnyPublisher<Bool, Error> {
    return self.favoriteDataSource.addToLocale(request: request!).eraseToAnyPublisher()
  }
  
}
