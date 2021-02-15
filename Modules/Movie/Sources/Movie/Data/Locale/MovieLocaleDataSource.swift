//
//  File.swift
//  
//
//  Created by Aji Saputra Raka Siwi on 15/02/21.
//

import Foundation
import Combine
import RealmSwift
import Core

public final class MovieLocaleDataSource {
  private let realm: Realm?
  
  public init(realm: Realm?) {
    self.realm = realm
  }
  
}

extension MovieLocaleDataSource: LocaleDataSource {
  public typealias Request = [MovieEntity]
  public typealias Response = [MovieEntity]
  
  public func getAllResponse() -> AnyPublisher<[MovieEntity], Error> {
    return Future<[MovieEntity], Error> { completion in
      if let realm = self.realm {
        let movies: Results<MovieEntity> = {
           realm.objects(MovieEntity.self)
            .sorted(byKeyPath: "title", ascending: true)
        }()
        let moviesArray = movies.toArray(ofType: MovieEntity.self)
        completion(.success(moviesArray))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  public func addToLocale(request: [MovieEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      DispatchQueue.main.async {
        if let realm = self.realm {
          do {
            try realm.write {
              for movie in request {
                realm.add(movie, update: .all)
              }
              completion(.success(true))
            }
          } catch {
            completion(.failure(DatabaseError.requestFailed))
          }
        } else {
          completion(.failure(DatabaseError.invalidInstance))
        }
      }
    }.eraseToAnyPublisher()
  }
  
  public func deleteFromLocale(request: [MovieEntity]) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
  
  public func getResponse(request: [MovieEntity]) -> AnyPublisher<Bool, Error> {
    fatalError()
  }

}
