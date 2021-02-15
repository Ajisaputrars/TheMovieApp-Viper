//
//  DetailPageController.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 30/01/21.
//

import UIKit
import Movie
import Core

class DetailPageController: UIViewController {
  private lazy var detailPageView = DetailPageView(frame: self.view.frame)
  private let presenter: DetailMoviePresenter<
    Interactor<
      MovieModel,
      Bool,
      GetFavoriteRepository<
        FavoriteLocaleDataSource
      >
    >,
    Interactor<
      MovieModel,
      Bool,
      AddMovieToFavoriteRepository<
        FavoriteLocaleDataSource
      >
    >,
    Interactor<
      MovieModel,
      Bool,
      DeleteMovieFromFavoriteRepository<
        FavoriteLocaleDataSource
      >
    >>
  private var favoriteButton: UIBarButtonItem!
  private var isFavorite = false
  
  init(presenter: DetailMoviePresenter<
       Interactor<
         MovieModel,
         Bool,
         GetFavoriteRepository<
           FavoriteLocaleDataSource
         >
       >,
       Interactor<
         MovieModel,
         Bool,
         AddMovieToFavoriteRepository<
           FavoriteLocaleDataSource
         >
       >,
       Interactor<
         MovieModel,
         Bool,
         DeleteMovieFromFavoriteRepository<
           FavoriteLocaleDataSource
         >
       >>) {
    
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view = self.detailPageView
    title = "Detail Movie"
    
    presenter.loadMovieDelegate = self
    presenter.loadFavoriteMovieDelegate = self
    
    favoriteButton = UIBarButtonItem(
      image: UIImage(systemName: "star"),
      style: .plain,
      target: self,
      action: #selector(favoriteButtonPressed(sender:))
    )
    navigationItem.rightBarButtonItem = favoriteButton
  }
  
  @objc
  private func favoriteButtonPressed(sender: UIBarButtonItem) {
    if presenter.isMovieInFavorite() {
      presenter.deleteMovieFromFavorite()
    } else {
      presenter.addMovieToFavorite()
    }
  }
}

extension DetailPageController: LoadDetailMovieDelegate {
  func loadMovie(movie: MovieModel) {
    detailPageView.setupDetailView(withMovieModel: movie)
  }
}

extension DetailPageController: FavoriteMovieDelegate {
  func favoriteStatus(isFavorite: Bool) {
    if isFavorite {
      favoriteButton.image = UIImage(systemName: "star.fill")
    } else {
      favoriteButton.image = UIImage(systemName: "star")
    }
  }
}
