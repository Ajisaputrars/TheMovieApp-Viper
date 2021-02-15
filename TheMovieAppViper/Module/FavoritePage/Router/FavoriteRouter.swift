//
//  FavoriteRouter.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 06/02/21.
//

import UIKit
import Movie

class FavoriteRouter {
  func goToDetailPage(from controller: UIViewController, withMovieModel movie: MovieModel) {
    let detailPageController = DetailPageController(presenter: DetailMoviePresenter(
      detailUseCase: Injection.init().provideDetailUseCase(movie: movie),
      favoriteUseCase: Injection.init().provideFavoriteMovieUseCase()
    ))
    detailPageController.hidesBottomBarWhenPushed = true
    controller.navigationController?.pushViewController(detailPageController, animated: true)
  }
}
