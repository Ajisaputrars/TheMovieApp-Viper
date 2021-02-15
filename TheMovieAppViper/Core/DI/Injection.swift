//
//  Injection.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 02/02/21.
//

import Foundation
import RealmSwift
import Movie
import Core

final class Injection {
  private func provideMovieRepository() -> GetMoviesRepository {
    let realm = try? Realm()
    let locale = MovieLocaleDataSource.shared(realm)
    let remote = RemoteDataSource.sharedInstance
    return GetMoviesRepository.shared(locale, remote)
  }
  
  private func provideFavoriteMovieRepository() -> FavoriteMovieRepository {
    let realm = try? Realm()
    let locale = FavoriteLocaleDataSource.shared(realm)
    return FavoriteMovieRepository.shared(locale)
  }
  
  func provideMovieUseCase() -> MovieUseCase {
    let repository = self.provideMovieRepository()
    return MovieInteractor(repository: repository)
  }

  func provideDetailUseCase(movie: MovieModel) -> DetailMovielUseCase {
    let repository = self.provideFavoriteMovieRepository()
    return DetailMovieInteractor(repository: repository, movie: movie)
  }
  
  func provideFavoriteMovieUseCase() -> FavoriteMovieUseCase {
    let repository = self.provideFavoriteMovieRepository()
    return FavoriteMovieInteractor(repository: repository)
  }
}
