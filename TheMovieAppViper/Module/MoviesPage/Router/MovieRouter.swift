//
//  MovieRouter.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 02/02/21.
//

import UIKit

class HomeRouter {
  func goToDetailPage(from controller: UIViewController, withMovieModel movie: MovieModel) {
    let detailPageController = DetailPageController(presenter: DetailMoviePresenter(
      detailUseCase: Injection.init().provideDetailUseCase(movie: movie),
      favoriteUseCase: Injection.init().provideFavoriteMovieUseCase()
    ))
    detailPageController.hidesBottomBarWhenPushed = true
    controller.navigationController?.pushViewController(detailPageController, animated: true)
  }
}
