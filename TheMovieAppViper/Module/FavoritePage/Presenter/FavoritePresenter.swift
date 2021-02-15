//
//  FavoritePresenter.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 06/02/21.
//

import UIKit
import Combine
import Movie

class FavoritePresenter {
  private let favoriteUseCase: FavoriteMovieUseCase
  private var cancellables: Set<AnyCancellable> = []
  weak var loadingFavoriteDelegate: LoadingMovieDelegate?
  private var favoriteMovies: [MovieModel] = []

  init(favoriteUseCase: FavoriteMovieUseCase) {
    self.favoriteUseCase = favoriteUseCase
  }
  
  func getFavoriteMovies() {
    self.loadingFavoriteDelegate?.loadingView(isLoading: true)
    self.favoriteUseCase.getAllFavoriteMovie()
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
  
  func goToDetailPage(from controller: UIViewController, withMovieModel movie: MovieModel) {
    FavoriteRouter().goToDetailPage(from: controller, withMovieModel: movie)
  }
}
