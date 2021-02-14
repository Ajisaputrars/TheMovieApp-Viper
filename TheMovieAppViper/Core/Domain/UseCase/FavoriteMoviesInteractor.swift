//
//  FavoriteMoviesInteractor.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 02/02/21.
//

import Foundation
import Combine

protocol FavoriteMovieUseCase {
  func getAllFavoriteMovie() -> AnyPublisher<[MovieModel], Error>
  func getFavoriteMovie(movie: MovieModel) -> AnyPublisher<Bool, Error>
  func addFavoriteMovie(movie: MovieModel) -> AnyPublisher<Bool, Error>
  func deleteFavoriteMovie(movie: MovieModel) -> AnyPublisher<Bool, Error>
}

class FavoriteMovieInteractor: FavoriteMovieUseCase {
  func getAllFavoriteMovie() -> AnyPublisher<[MovieModel], Error> {
    repository.getAllFavoriteMovies()
  }
  
  private let repository: FavoriteMovieRepositoryProtocol

  required init(repository: FavoriteMovieRepositoryProtocol) {
    self.repository = repository
  }
  
  func getFavoriteMovie(movie: MovieModel) -> AnyPublisher<Bool, Error> {
    repository.getFavoriteMovies(movie: movie)
  }
  
  func addFavoriteMovie(movie: MovieModel) -> AnyPublisher<Bool, Error> {
    repository.addFavoriteMovie(movie: movie)
  }
  
  func deleteFavoriteMovie(movie: MovieModel) -> AnyPublisher<Bool, Error> {
    repository.deleteFavoriteMovie(movie: movie)
  }
}
