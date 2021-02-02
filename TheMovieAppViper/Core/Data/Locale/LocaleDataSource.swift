//
//  LocalDataSourceProtocol.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 02/02/21.
//

import Foundation
import Combine
import RealmSwift

protocol LocaleDataSourceProtocol {
  func getMovies() -> AnyPublisher<[MovieEntity], Error>
  func addMoviesToLocalStorage(from categories: [MovieEntity]) -> AnyPublisher<Bool, Error>
}

final class LocaleDataSource {
  private let realm: Realm?
  
  private init(realm: Realm?) {
    self.realm = realm
  }
  
  static var shared: (Realm?) -> LocaleDataSource = { realm in
    return LocaleDataSource(realm: realm)
  }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
  func getMovies() -> AnyPublisher<[MovieEntity], Error> {
    return Future<[MovieEntity], Error> { completion in
      if let realm = self.realm {
        let movies: Results<MovieEntity> = {
          realm.objects(MovieEntity.self)
            .sorted(byKeyPath: "title", ascending: true)
        }()
        completion(.success(movies.toArray(ofType: MovieEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func addMoviesToLocalStorage(from movies: [MovieEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      DispatchQueue.main.async {
        if let realm = self.realm {
          do {
            try realm.write {
              for movie in movies {
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
}

extension Results {

  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }

}

enum DatabaseError: LocalizedError {

  case invalidInstance
  case requestFailed
  
  var errorDescription: String? {
    switch self {
    case .invalidInstance: return "Database can't instance."
    case .requestFailed: return "Your request failed."
    }
  }

}
