//
//  MoviesInteractor.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 02/02/21.
//

import Foundation
import Combine
import Movie
import Core

protocol MovieUseCase {
  func getMovies(withQuery query: String?) -> AnyPublisher<[MovieModel], Error>
}

class MovieInteractor: MovieUseCase {
  private let repository: MovieRepository
  
  required init(repository: MovieRepository) {
    self.repository = repository
  }
  
  func getMovies(withQuery query: String? = nil) -> AnyPublisher<[MovieModel], Error> {
    return repository.execute(request: query)
  }

}
