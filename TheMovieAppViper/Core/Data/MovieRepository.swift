//
//  MovieRepository.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 02/02/21.
//

import Foundation
import Combine

protocol MovieRepositoryProtocol {
  func getMovies() -> AnyPublisher<[MovieModel], Error>
}

final class MovieRepository {
  private let remote: RemoteDataSource
  private let locale: LocaleDataSource
  
  private init(locale: LocaleDataSource, remote: RemoteDataSource) {
    self.remote = remote
    self.locale = locale
  }
  
  static let shared = { localeRepo, remoteRepo in
    return MovieRepository(locale: localeRepo, remote: remoteRepo)
  }
}

extension MovieRepository: MovieRepositoryProtocol {
  func getMovies() -> AnyPublisher<[MovieModel], Error> {
    return self.locale.getMovies()
      .flatMap { result -> AnyPublisher<[MovieModel], Error> in
        if result.isEmpty {
          return self.remote.getCategories()
            .map { MovieMapper.mapMovieResultResponsesToEntities(input: $0) }
            .flatMap { self.locale.addMoviesToLocalStorage(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.locale.getMovies()
              .map { MovieMapper.mapMovieEntitiesToDomains(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getMovies()
            .map { MovieMapper.mapMovieEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
}
