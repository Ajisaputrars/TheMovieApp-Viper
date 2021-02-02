//
//  MoviesInteractor.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 02/02/21.
//

import Foundation
import Combine

protocol MovieUseCase {
  func getCategories() -> AnyPublisher<[MovieModel], Error>
}

class MovieInteractor: MovieUseCase {
  private let repository: MovieRepositoryProtocol
  
  required init(repository: MovieRepositoryProtocol) {
    self.repository = repository
  }
  
  func getCategories() -> AnyPublisher<[MovieModel], Error> {
    return repository.getMovies()
  }

}
