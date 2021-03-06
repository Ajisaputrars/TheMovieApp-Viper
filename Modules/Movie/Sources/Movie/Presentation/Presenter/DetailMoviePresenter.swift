//
//  DetailMoviePresenter.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 04/02/21.
//

import Foundation
import Combine
import Core

public class DetailMoviePresenter<GetFavoriteUseCase: UseCase, AddFavoriteUseCase: UseCase, DeleteFavoriteUseCase: UseCase>
where
  GetFavoriteUseCase.Request == MovieModel, GetFavoriteUseCase.Response == Bool,
  AddFavoriteUseCase.Request == MovieModel, AddFavoriteUseCase.Response == Bool,
  DeleteFavoriteUseCase.Request == MovieModel, DeleteFavoriteUseCase.Response == Bool
{
  private let getFavoriteUseCase: GetFavoriteUseCase
  private let addFavoriteUseCase: AddFavoriteUseCase
  private let deleteFavoriteUseCase: DeleteFavoriteUseCase
  private let movie: MovieModel
  private var favoriteMovie: MovieModel!
  private var cancellables: Set<AnyCancellable> = []
  private var isInFavorite = false
  
  public weak var loadMovieDelegate: LoadDetailMovieDelegate? {
    didSet {
      self.loadMovieDelegate?.loadMovie(movie: movie)
    }
  }
  public weak var loadFavoriteMovieDelegate: FavoriteMovieDelegate?
  
  public init(getFavoriteUseCase: GetFavoriteUseCase, addFavoriteUseCase: AddFavoriteUseCase, deleteFavoriteUseCase: DeleteFavoriteUseCase, movie: MovieModel) {
    self.getFavoriteUseCase = getFavoriteUseCase
    self.addFavoriteUseCase = addFavoriteUseCase
    self.deleteFavoriteUseCase = deleteFavoriteUseCase
    self.movie = movie
    self.loadFavoriteMovie()
  }
  
  private func loadFavoriteMovie() {
    getFavoriteUseCase.execute(request: movie)
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
        case .failure: break
        case .finished : break
        }
      } receiveValue: { _ in
        self.isInFavorite = true
        self.loadFavoriteMovieDelegate?.favoriteStatus(isFavorite: self.isInFavorite)
      }.store(in: &cancellables)
  }
  
  public func isMovieInFavorite() -> Bool {
    return isInFavorite
  }
  
  public func addMovieToFavorite() {
    addFavoriteUseCase.execute(request: movie)
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
  
  public func deleteMovieFromFavorite() {
    if isInFavorite {
      deleteFavoriteUseCase.execute(request: movie)
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

public protocol LoadDetailMovieDelegate: class {
  func loadMovie(movie: MovieModel)
}

public protocol FavoriteMovieDelegate: class {
  func favoriteStatus(isFavorite: Bool)
}
