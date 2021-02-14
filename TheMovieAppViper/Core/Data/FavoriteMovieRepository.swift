//
//  FavoriteRepository.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 04/02/21.
//

import Foundation
import Combine

protocol FavoriteMovieRepositoryProtocol {
  func getAllFavoriteMovies() -> AnyPublisher<[MovieModel], Error>
  func getFavoriteMovies(movie: MovieModel) -> AnyPublisher<Bool, Error>
  func deleteFavoriteMovie(movie: MovieModel) -> AnyPublisher<Bool, Error>
  func addFavoriteMovie(movie: MovieModel) -> AnyPublisher<Bool, Error>
}

final class FavoriteMovieRepository {
  private let favoriteDataSource: FavoriteDataSource
  
  private init(favoriteDataSource: FavoriteDataSource) {
    self.favoriteDataSource = favoriteDataSource
  }
  
  static let shared = { dataSource in
    return FavoriteMovieRepository(favoriteDataSource: dataSource)
  }
}

extension FavoriteMovieRepository: FavoriteMovieRepositoryProtocol {
  func getAllFavoriteMovies() -> AnyPublisher<[MovieModel], Error> {
    return favoriteDataSource.getAllFavoriteMovie().map {
      MovieMapper.mapMovieFavoritesEntityToDomains(input: $0)
    }
    .eraseToAnyPublisher()
  }
  
  func getFavoriteMovies(movie: MovieModel) -> AnyPublisher<Bool, Error> {
    return self.favoriteDataSource.getFavoriteMovie(movie: movie).map {_ in 
      return true
//      MovieMapper.mapMovieFavoriteEntityToDomain(input: $0)
    }
    .eraseToAnyPublisher()
  }
  
  func deleteFavoriteMovie(movie: MovieModel) -> AnyPublisher<Bool, Error> {
    return self.favoriteDataSource.deleteFavoriteMovie(movie: movie).eraseToAnyPublisher()
  }
  
  func addFavoriteMovie(movie: MovieModel) -> AnyPublisher<Bool, Error> {
    return self.favoriteDataSource.addMovieToFavorite(movie: movie).eraseToAnyPublisher()
  }
}
