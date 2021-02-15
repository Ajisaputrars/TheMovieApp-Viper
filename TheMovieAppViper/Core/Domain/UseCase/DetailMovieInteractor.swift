//
//  DetailMoviesInteractor.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 02/02/21.
//

import Foundation
import Combine
import Movie

protocol DetailMovielUseCase {
  func getMovie() -> MovieModel
}

class DetailMovieInteractor: DetailMovielUseCase {
  private let repository: FavoriteMovieRepository
  private let movie: MovieModel

  required init(repository: FavoriteMovieRepository, movie: MovieModel) {
    self.repository = repository
    self.movie = movie
  }

  func getMovie() -> MovieModel {
    return movie
  }
}
