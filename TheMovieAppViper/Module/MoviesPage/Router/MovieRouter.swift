//
//  MovieRouter.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 02/02/21.
//

import UIKit
import Movie

class MovieRouter {
  func goToDetailPage(from controller: UIViewController, withMovieModel movie: MovieModel) {
    let detailPageController = DetailPageController(
      presenter: DetailMoviePresenter(
        getFavoriteUseCase: Injection().provideGetFavoriteMovieUseCase(),
        addFavoriteUseCase: Injection().provideAddFavoriteMovieUseCase(),
        deleteFavoriteUseCase: Injection().provideDeleteFavoriteMovieUseCase(),
        movie: movie)
    )
    detailPageController.hidesBottomBarWhenPushed = true
    controller.navigationController?.pushViewController(detailPageController, animated: true)
  }
}
