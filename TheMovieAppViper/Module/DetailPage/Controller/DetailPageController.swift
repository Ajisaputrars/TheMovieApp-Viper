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
  private var favoriteButton: UIBarButtonItem!
  private var isFavorite = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view = self.detailPageView
    title = "Detail Movie"
    
    presenter?.loadMovieDelegate = self
    presenter?.loadDetailMovie()
    
    favoriteButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(favoriteButtonPressed(sender:)))
    navigationItem.rightBarButtonItem = favoriteButton
  }
  
  @objc
  private func favoriteButtonPressed(sender: UIBarButtonItem) {
    isFavorite = !isFavorite
    if isFavorite {
      favoriteButton.image = UIImage(systemName: "star.fill")
    } else {
      favoriteButton.image = UIImage(systemName: "star")
    }
  }
}

extension DetailPageController: LoadDetailMovieDelegate {
  func loadMovie(movie: MovieModel) {
    detailPageView.setupDetailView(withMovieModel: movie)
  }
}
