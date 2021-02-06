//
//  DetailMoviePresenter.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 04/02/21.
//

import Foundation
import Combine

class DetailMoviePresenter {
  private let detailUseCase: DetailMovielUseCase
  private let favoriteUseCase: FavoriteMovieUseCase
  private var movie: MovieModel
  private var favoriteMovie: MovieModel!
  private var cancellables: Set<AnyCancellable> = []
  private var isInFavorite = false
  
  weak var loadMovieDelegate: LoadDetailMovieDelegate? {
    didSet {
      self.loadMovieDelegate?.loadMovie(movie: movie)
    }
  }
  weak var loadFavoriteMovieDelegate: FavoriteMovieDelegate?
  
  init(detailUseCase: DetailMovielUseCase, favoriteUseCase: FavoriteMovieUseCase) {
    self.detailUseCase = detailUseCase
    self.favoriteUseCase = favoriteUseCase
    self.movie = detailUseCase.getMovie()
    self.loadFavoriteMovie()
  }
  
  private func loadFavoriteMovie() {
    favoriteUseCase.getFavoriteMovie(movie: movie)
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
        case .failure: break
        case .finished : break
        }
      } receiveValue: { movie in
        self.favoriteMovie = movie
        self.isInFavorite = true
        self.loadFavoriteMovieDelegate?.favoriteStatus(isFavorite: self.isInFavorite)
      }.store(in: &cancellables)
  }
  
  func isMovieInFavorite() -> Bool {
    return isInFavorite
  }
  
  func addMovieToFavorite() {
    favoriteUseCase.addFavoriteMovie(movie: movie)
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
        case .failure: break
        case .finished: break
        }
      } receiveValue: { _ in
        self.loadFavoriteMovie()
      }.store(in: &cancellables)
  }
  
  func deleteMovieFromFavorite() {
    if favoriteMovie != nil {
      favoriteUseCase.deleteFavoriteMovie(movie: favoriteMovie)
        .receive(on: RunLoop.main)
        .sink { completion in
          switch completion {
          case .failure: break
          case .finished: break
          }
        } receiveValue: { _ in
          self.isInFavorite = false
          self.loadFavoriteMovieDelegate?.favoriteStatus(isFavorite: self.isInFavorite)
        }.store(in: &cancellables)
    }
  }
  
}

protocol LoadDetailMovieDelegate: class {
  func loadMovie(movie: MovieModel)
}

protocol FavoriteMovieDelegate: class {
  func favoriteStatus(isFavorite: Bool)
}
