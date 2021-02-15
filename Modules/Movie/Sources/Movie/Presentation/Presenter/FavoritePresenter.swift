//
//  FavoritePresenter.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 06/02/21.
//

import UIKit
import Combine
import Core

public class FavoritePresenter<Request, Response, Interactor: UseCase> where Interactor.Request == Request, Interactor.Response == [MovieModel] {
  private let favoriteUseCase: Interactor
  private var cancellables: Set<AnyCancellable> = []
  public weak var loadingFavoriteDelegate: LoadingMovieDelegate?
  private var favoriteMovies: [MovieModel] = []

  public init(favoriteUseCase: Interactor) {
    self.favoriteUseCase = favoriteUseCase
  }
  
  public func getFavoriteMovies() {
    self.loadingFavoriteDelegate?.loadingView(isLoading: true)
    self.favoriteUseCase.execute(request: nil)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        self.loadingFavoriteDelegate?.loadingView(isLoading: false)
        if self.favoriteMovies.count <= 0 {
          self.loadingFavoriteDelegate?.noData()
        }
        switch completion {
        case .failure:
          self.loadingFavoriteDelegate?.getErrorMessage(errorMessage: String(describing: completion))
        case .finished:
          break
        }
      }, receiveValue: { favoriteMovies in
        self.favoriteMovies = favoriteMovies
        self.loadingFavoriteDelegate?.setMovie(movies: self.favoriteMovies)
      })
      .store(in: &cancellables)
  }
  
}
