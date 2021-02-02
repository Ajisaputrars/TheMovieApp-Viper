//
//  Injection.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 02/02/21.
//

import Foundation
import RealmSwift

final class Injection {
  private func provideRepository() -> MovieRepositoryProtocol {
    let realm = try? Realm()
    let locale = LocaleDataSource.shared(realm)
    let remote = RemoteDataSource.sharedInstance
    return MovieRepository.shared(locale, remote)
  }
  
  func provideMovieUseCase() -> MovieUseCase {
    let repository = self.provideRepository()
    return MovieInteractor(repository: repository)
  }

  func provideDetailUseCase(movie: MovieModel) -> DetailMovielUseCase {
    let repository = self.provideRepository()
    return DetailMovieInteractor(repository: repository, movie: movie)
  }
}
