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

public final class FavoriteLocaleDataSource: LocaleDataSource {
  public typealias Request = MovieModel
  public typealias Response = [FavoriteMovieEntity]
  
  private let realm: Realm?
  
  private init(realm: Realm?) {
    self.realm = realm
  }
  
  public static var shared: (Realm?) -> FavoriteLocaleDataSource = { realm in
    return FavoriteLocaleDataSource(realm: realm)
  }
}

extension FavoriteLocaleDataSource {
  public func getAllResponse() -> AnyPublisher<[FavoriteMovieEntity], Error> {
    return Future<[FavoriteMovieEntity], Error> { completion in
      if let realm = self.realm {
        let favoriteMovies: Results<FavoriteMovieEntity> = {
           realm.objects(FavoriteMovieEntity.self)
        }()
        let moviesArray = favoriteMovies.toArray(ofType: FavoriteMovieEntity.self)
        completion(.success(moviesArray))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  public func getResponse(request: MovieModel) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        if realm.objects(FavoriteMovieEntity.self)
            .filter("id = \(request.id)").first != nil {
          completion(.success(true))
        } else {
          completion(.failure(DatabaseError.invalidInstance))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  public func addToLocale(request: MovieModel) -> AnyPublisher<Bool, Error> {
    let favoriteMovieEntity = FavoriteTransformer().transformDomainToEntity(domain: request)
    return Future<Bool, Error> { completion in
      DispatchQueue.main.async {
        if let realm = self.realm {
          do {
            try realm.write {
              realm.add(favoriteMovieEntity, update: .all)
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
  
  public func deleteFromLocale(request: MovieModel) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      DispatchQueue.main.async {
        if let realm = self.realm {
          do {
            try realm.write {
              realm.delete(realm.objects(FavoriteMovieEntity.self).filter("id=%@", request.id))
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
