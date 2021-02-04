//
//  Injection.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 02/02/21.
//

import Foundation
import RealmSwift

final class Injection {
  private func provideMovieRepository() -> MovieRepositoryProtocol {
    let realm = try? Realm()
    let locale = LocaleDataSource.shared(realm)
    let remote = RemoteDataSource.sharedInstance
    return MovieRepository.shared(locale, remote)
  }
  
  private func provideFavoriteMovieRepository() -> FavoriteMovieRepositoryProtocol {
    let realm = try? Realm()
    let locale = FavoriteDataSource.shared(realm)
    return FavoriteMovieRepository.shared(locale)
  }
  
  func provideMovieUseCase() -> MovieUseCase {
    let repository = self.provideMovieRepository()
    return MovieInteractor(repository: repository)
  }

  func provideDetailUseCase(movie: MovieModel) -> DetailMovielUseCase {
    let repository = self.provideMovieRepository()
    return DetailMovieInteractor(repository: repository, movie: movie)
  }
}
