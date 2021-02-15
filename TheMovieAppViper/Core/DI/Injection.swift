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
  
  func provideMovieUseCase<U: UseCase>() -> U where U.Request == String, U.Response == [MovieModel] {
    let locale = MovieLocaleDataSource(realm: realm)
    let remote = MovieRemoteDataSource(request: Utils.getApiKey())
    let repository = GetMoviesRepository(locale: locale, remote: remote)
    
    return Interactor(repository: repository) as! U
  }
  
  func provideGetAllFavoriteMovieUseCase<U: UseCase>() -> U where U.Request == MovieModel, U.Response == [MovieModel] {
    let locale = FavoriteLocaleDataSource(realm: realm)
    let repository = GetAllFavoritesRepository(favoriteDataSource: locale)
    return Interactor(repository: repository) as! U
  }
  
  func provideGetFavoriteMovieUseCase<U: UseCase>() -> U where U.Request == MovieModel, U.Response == Bool{
    let locale = FavoriteLocaleDataSource(realm: realm)
    let repository = GetFavoriteRepository(favoriteDataSource: locale)
    return Interactor(repository: repository) as! U
  }
  
  func provideAddFavoriteMovieUseCase<U: UseCase>() -> U where U.Request == MovieModel, U.Response == Bool {
    let locale = FavoriteLocaleDataSource(realm: realm)
    let repository = AddMovieToFavoriteRepository(favoriteDataSource: locale)
    return Interactor(repository: repository) as! U
  }
  
  func provideDeleteFavoriteMovieUseCase<U: UseCase>() -> U where U.Request == MovieModel, U.Response == Bool {
    let locale = FavoriteLocaleDataSource(realm: realm)
    let repository = DeleteMovieFromFavoriteRepository(favoriteDataSource: locale)
    return Interactor(repository: repository) as! U
  }
  
}
