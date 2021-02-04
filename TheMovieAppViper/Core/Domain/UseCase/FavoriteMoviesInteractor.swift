//
//  FavoriteMoviesInteractor.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 02/02/21.
//

import Foundation
import Combine

protocol FavoriteMovieUseCase {
  func getFavoriteMovie(id: Int) -> AnyPublisher<[MovieModel], Error>
  func addFavoriteMovie(movie: MovieModel) -> AnyPublisher<Bool, Error>
  func deleteFavoriteMovie(movie: MovieModel) -> AnyPublisher<Bool, Error>
}
