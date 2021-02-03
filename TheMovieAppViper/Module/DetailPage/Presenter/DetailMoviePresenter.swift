//
//  DetailMoviePresenter.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 04/02/21.
//

import Foundation

class DetailMoviePresenter {
  private let useCase: DetailMovielUseCase
  weak var loadMovieDelegate: LoadDetailMovieDelegate?
  
  init(detailUseCase: DetailMovielUseCase) {
    useCase = detailUseCase
  }
  
  func loadDetailMovie() {
    loadMovieDelegate?.loadMovie(movie: useCase.getMovie())
  }
}

protocol LoadDetailMovieDelegate: class {
  func loadMovie(movie: MovieModel)
}
