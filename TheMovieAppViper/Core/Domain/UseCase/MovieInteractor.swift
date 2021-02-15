//
//  MoviesInteractor.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 02/02/21.
//

import Foundation
import Combine
import Movie

protocol MovieUseCase {
  func getMovies(withQuery query: String?) -> AnyPublisher<[MovieModel], Error>
}

class MovieInteractor: MovieUseCase {
  private let repository: MovieRepositoryProtocol
  
  required init(repository: MovieRepositoryProtocol) {
    self.repository = repository
  }
  
  func getMovies(withQuery query: String? = nil) -> AnyPublisher<[MovieModel], Error> {
    return repository.getMovies(withQuery: query)
  }

}
