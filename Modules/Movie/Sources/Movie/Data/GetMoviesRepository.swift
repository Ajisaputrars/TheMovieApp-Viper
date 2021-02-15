//
//  File.swift
//  
//
//  Created by Aji Saputra Raka Siwi on 15/02/21.
//

import Foundation
import Combine
import Core

public final class GetMoviesRepository<
  LocaleMovieDataSource: LocaleDataSource,
  RemoteMovieDataSource: DataSource,
  Transformer: Mapper
> where
  LocaleMovieDataSource.Response == [MovieEntity],
  RemoteMovieDataSource.Response == [MovieModel],
  Transformer.Entity == [MovieEntity],
  Transformer.Response == [MovieResultResponse],
  Transformer.Domain == [MovieModel]
{
  private let locale: MovieLocaleDataSource
  private let remote: RemoteDataSource
  private let mapper: Transformer
  
  public init(locale: MovieLocaleDataSource, remote: RemoteDataSource, mapper: Transformer) {
    self.remote = remote
    self.locale = locale
    self.mapper = mapper
  }
 
}

extension GetMoviesRepository: Repository {
  public typealias Request = String
  public typealias Response = [MovieModel]
  
  public func execute(request: String?) -> AnyPublisher<[MovieModel], Error> {
    if let request = request {
      return self.remote.execute(request: request).map { self.mapper.transformResponseToDomain(response: $0) }
        .eraseToAnyPublisher()
    } else {
      return self.locale.getAllResponse().flatMap { result -> AnyPublisher<[MovieModel], Error> in
        if result.isEmpty {
          return self.remote.execute(request: request).map {
            self.mapper.transformResponseToEntity(
              request: nil,
              response: $0)}
            .flatMap { self.locale.addToLocale(request: $0)}
            .filter { $0 }
            .flatMap { _ in self.locale.getAllResponse().map { self.mapper.transformEntityToDomain(entity: $0) }
            }.eraseToAnyPublisher()
        } else {
          return self.locale.getAllResponse().map { self.mapper.transformEntityToDomain(entity: $0)}
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
    }
  }

}
