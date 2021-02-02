//
//  MovieRouter.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 02/02/21.
//

import UIKit

class HomeRouter {
  func goToDetailPage(from controller: UIViewController, withMovieModel movie: MovieModel?) {
    let detailPageController = DetailPageController()
    detailPageController.movie = movie
    controller.navigationController?.pushViewController(detailPageController, animated: true)
  }
}
