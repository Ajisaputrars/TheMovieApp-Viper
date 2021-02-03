//
//  DetailPageController.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 30/01/21.
//

import UIKit

class DetailPageController: UIViewController {
  private lazy var detailPageView = DetailPageView(frame: self.view.frame)
  var presenter: DetailMoviePresenter?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view = self.detailPageView
    title = "Detail Movie"
    
    presenter?.loadMovieDelegate = self
    presenter?.loadDetailMovie()
  }
}

extension DetailPageController: LoadDetailMovieDelegate {
  func loadMovie(movie: MovieModel) {
    detailPageView.setupDetailView(withMovieModel: movie)
  }
}
