//
//  DetailMoviesInteractor.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 02/02/21.
//

import Foundation

protocol DetailMovielUseCase {
  func getMovie() -> MovieModel
}

class DetailMovieInteractor: DetailMovielUseCase {
  private let repository: MovieRepositoryProtocol
  private let movie: MovieModel

  required init(repository: MovieRepositoryProtocol, movie: MovieModel) {
    self.repository = repository
    self.movie = movie
  }

  func getMovie() -> MovieModel {
    return movie
  }
}
