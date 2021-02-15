//
//  MovieRepository.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 02/02/21.
//

import Foundation
import Combine
import Movie
import Core

protocol MovieRepositoryProtocol {
  func getMovies(withQuery query: String?) -> AnyPublisher<[MovieModel], Error>
}

final class MovieRepository {
  private let remote: RemoteDataSource
  private let locale: MovieLocaleDataSource
  
  private init(locale: MovieLocaleDataSource, remote: RemoteDataSource) {
    self.remote = remote
    self.locale = locale
  }
  
  static let shared = { localeRepo, remoteRepo in
    return MovieRepository(locale: localeRepo, remote: remoteRepo)
  }
}

extension MovieRepository: MovieRepositoryProtocol {
  func getMovies(withQuery query: String?) -> AnyPublisher<[MovieModel], Error> {
    if let query = query {
      return self.remote.getMovies(withQuery: query).map { MovieMapper.mapMovieResultResponseToDomains(input: $0) }
        .eraseToAnyPublisher()
    } else {
      return self.locale.getAllResponse().flatMap { result -> AnyPublisher<[MovieModel], Error> in
        if result.isEmpty {
          return self.remote.getMovies().map { MovieMapper.mapMovieResultResponsesToEntities(input: $0) }
            .flatMap { self.locale.addToLocale(request: $0)}
            .filter { $0 }
            .flatMap { _ in self.locale.getAllResponse().map { MovieMapper.mapMovieEntitiesToDomains(input: $0) }
            }.eraseToAnyPublisher()
        } else {
          return self.locale.getAllResponse().map { MovieMapper.mapMovieEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
    }
  }
}
