//
//  File.swift
//  
//
//  Created by Aji Saputra Raka Siwi on 15/02/21.
//

import Foundation
import Combine
import Core

public final class GetMoviesRepository {
  private let remote: RemoteDataSource
  private let locale: MovieLocaleDataSource
  
  private init(locale: MovieLocaleDataSource, remote: RemoteDataSource) {
    self.remote = remote
    self.locale = locale
  }
  
  public static let shared = { localeRepo, remoteRepo in
    return GetMoviesRepository(locale: localeRepo, remote: remoteRepo)
  }
}

extension GetMoviesRepository: DataSource {
  public typealias Request = String
  public typealias Response = [MovieModel]
  
  public func execute(request: String?) -> AnyPublisher<[MovieModel], Error> {
    if let request = request {
      return self.remote.execute(request: request).map { MovieTransformer().transformResponseToDomain(response: $0) }
        .eraseToAnyPublisher()
    } else {
      return self.locale.getAllResponse().flatMap { result -> AnyPublisher<[MovieModel], Error> in
        if result.isEmpty {
          return self.remote.execute(request: request).map {
            MovieTransformer().transformResponseToEntity(
              request: nil,
              response: $0)}
            .flatMap { self.locale.addToLocale(request: $0)}
            .filter { $0 }
            .flatMap { _ in self.locale.getAllResponse().map { MovieTransformer().transformEntityToDomain(entity: $0) }
            }.eraseToAnyPublisher()
        } else {
          return self.locale.getAllResponse().map { MovieTransformer().transformEntityToDomain(entity: $0)}
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
    }
  }

}
