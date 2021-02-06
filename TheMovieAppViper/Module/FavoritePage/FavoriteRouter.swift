//
//  FavoriteRouter.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 06/02/21.
//

import UIKit

class FavoriteRouter {
  func goToDetailPage(from controller: UIViewController, withMovieModel movie: MovieModel) {
    let detailPageController = DetailPageController()
    detailPageController.hidesBottomBarWhenPushed = true
    let detailUseCase = Injection.init().provideDetailUseCase(movie: movie)
    let favoriteUseCase = Injection.init().provideFavoriteMovieUseCase()
    detailPageController.presenter = DetailMoviePresenter(
      detailUseCase: detailUseCase,
      favoriteUseCase: favoriteUseCase
    )
    controller.navigationController?.pushViewController(detailPageController, animated: true)
  }
}
