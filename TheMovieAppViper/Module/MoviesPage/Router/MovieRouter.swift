//
//  MovieRouter.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 02/02/21.
//

import UIKit

class HomeRouter {
  func goToDetailPage(from controller: UIViewController, withMovieModel movie: MovieModel) {
    let detailPageController = DetailPageController()
    let detailUseCase = Injection.init().provideDetailUseCase(movie: movie)
    detailPageController.presenter = DetailMoviePresenter(detailUseCase: detailUseCase)
    detailPageController.hidesBottomBarWhenPushed = true
    controller.navigationController?.pushViewController(detailPageController, animated: true)
  }
}
