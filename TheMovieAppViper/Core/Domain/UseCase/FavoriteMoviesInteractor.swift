//
//  FavoriteMoviesInteractor.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 02/02/21.
//

import Foundation
import Combine
import Core
import Movie

protocol FavoriteMovieUseCase {
  func getAllFavoriteMovie() -> AnyPublisher<[MovieModel], Error>
  func getFavoriteMovie(movie: MovieModel) -> AnyPublisher<Bool, Error>
  func addFavoriteMovie(movie: MovieModel) -> AnyPublisher<Bool, Error>
  func deleteFavoriteMovie(movie: MovieModel) -> AnyPublisher<Bool, Error>
}

class FavoriteMovieInteractor: FavoriteMovieUseCase {
  func getAllFavoriteMovie() -> AnyPublisher<[MovieModel], Error> {
    repository.getAllResponse()
  }
  
  private let repository: FavoriteMovieRepository

  required init(repository: FavoriteMovieRepository) {
    self.repository = repository
  }
  
  func getFavoriteMovie(movie: MovieModel) -> AnyPublisher<Bool, Error> {
    repository.getResponse(request: movie)
  }
  
  func addFavoriteMovie(movie: MovieModel) -> AnyPublisher<Bool, Error> {
    repository.addToLocale(request: movie)
  }
  
  func deleteFavoriteMovie(movie: MovieModel) -> AnyPublisher<Bool, Error> {
    repository.deleteFromLocale(request: movie)
  }
}
