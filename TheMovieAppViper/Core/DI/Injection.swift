//
//  Injection.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 02/02/21.
//

import UIKit
import RealmSwift
import Movie
import Core

final class Injection {
  let realm = (UIApplication.shared.delegate as! AppDelegate).realm

//  private func provideMovieRepository() -> GetMoviesRepository {
//    let realm = try? Realm()
//    let locale = MovieLocaleDataSource.shared(realm)
//    let remote = MovieRemoteDataSource.shared
//    return GetMoviesRepository.shared(locale, remote)
//  }
  
  func provideMovieUseCase<U: UseCase>() -> U where U.Request == Any, U.Response == [MovieModel] {
    let locale = MovieLocaleDataSource(realm: realm)
    let remote = MovieRemoteDataSource(request: Utils.getApiKey())
    let repository = GetMoviesRepository(locale: locale, remote: remote)
    
    return Interactor(repository: repository) as! U
  }
  
//  private func provideFavoriteMovieRepository() -> FavoriteMovieRepository {
//    let realm = try? Realm()
//    let locale = FavoriteLocaleDataSource.shared(realm)
//    return FavoriteMovieRepository.shared(locale)
//  }
  
  func provideGetAllFavoriteMovieUseCase<U: UseCase>() -> U where U.Request == Any, U.Response == [MovieModel] {
    let locale = FavoriteLocaleDataSource(realm: realm)
    let repository = GetAllFavoritesRepository(favoriteDataSource: locale)
    return Interactor(repository: repository) as! U
  }
  
  func provideGetFavoriteMovieUseCase<U: UseCase>() -> U where U.Request == Any, U.Response == [MovieModel] {
    let locale = FavoriteLocaleDataSource(realm: realm)
    let repository = GetFavoriteRepository(favoriteDataSource: locale)
    return Interactor(repository: repository) as! U
  }
  
  func provideAddFavoriteMovieUseCase<U: UseCase>() -> U where U.Request == Any, U.Response == [MovieModel] {
    let locale = FavoriteLocaleDataSource(realm: realm)
    let repository = AddMovieToFavoriteRepository(favoriteDataSource: locale)
    return Interactor(repository: repository) as! U
  }
  
  func provideDeleteFavoriteMovieUseCase<U: UseCase>() -> U where U.Request == Any, U.Response == [MovieModel] {
    let locale = FavoriteLocaleDataSource(realm: realm)
    let repository = DeleteMovieFromFavoriteRepository(favoriteDataSource: locale)
    return Interactor(repository: repository) as! U
  }
  
//  func provideMovieUseCase() -> MovieUseCase {
//    let repository = self.provideMovieRepository()
//    return MovieInteractor(repository: repository)
//  }

//  func provideDetailUseCase(movie: MovieModel) -> DetailMovielUseCase {
//    let repository = self.provideFavoriteMovieRepository()
//    return DetailMovieInteractor(repository: repository, movie: movie)
//  }
//
//  func provideFavoriteMovieUseCase() -> FavoriteMovieUseCase {
//    let repository = self.provideFavoriteMovieRepository()
//    return FavoriteMovieInteractor(repository: repository)
//  }
}
