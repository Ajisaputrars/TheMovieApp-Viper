//
//  FavoriteDataSource.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 04/02/21.
//

import Foundation
import Combine
import RealmSwift

protocol FavoriteDataSourceProtocol {
  func getAllFavoriteMovie() -> AnyPublisher<[FavoriteMovieEntity], Error>
  func getFavoriteMovie(movie: MovieModel) -> AnyPublisher<Bool, Error>
  func addMovieToFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error>
  func deleteFavoriteMovie(movie: MovieModel) -> AnyPublisher<Bool, Error>
}

final class FavoriteDataSource {
  private let realm: Realm?
  
  private init(realm: Realm?) {
    self.realm = realm
  }
  
  static var shared: (Realm?) -> FavoriteDataSource = { realm in
    return FavoriteDataSource(realm: realm)
  }
}

extension FavoriteDataSource: FavoriteDataSourceProtocol {
  func getAllFavoriteMovie() -> AnyPublisher<[FavoriteMovieEntity], Error> {
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
  
  func getFavoriteMovie(movie: MovieModel) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        if let _ = realm.objects(FavoriteMovieEntity.self)
            .filter("id = \(movie.id)").first {
          completion(.success(true))
        } else {
          completion(.failure(DatabaseError.invalidInstance))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func addMovieToFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error> {
    let favoriteMovieEntity = MovieMapper.mapDomainToMovieFavoriteEntity(input: movie)
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
  
  func deleteFavoriteMovie(movie: MovieModel) -> AnyPublisher<Bool, Error> {
//    let favoriteMovieEntity = MovieMapper.mapDomainToMovieFavoriteEntity(input: movie)
    return Future<Bool, Error> { completion in
      DispatchQueue.main.async {
        if let realm = self.realm {
          do {
            try realm.write {
              realm.delete(realm.objects(FavoriteMovieEntity.self).filter("id=%@", movie.id))
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
