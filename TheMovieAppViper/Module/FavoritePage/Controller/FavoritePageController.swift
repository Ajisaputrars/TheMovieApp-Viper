//
//  FavoritePageController.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 01/02/21.
//

import UIKit

class FavoritePageController: UIViewController {
  private lazy var moviePageView = MoviePageView(frame: self.view.frame)
  var presenter: FavoritePresenter!
  private var favoriteMovies: [MovieModel] = []
  
  init(presenter: FavoritePresenter) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view = self.moviePageView
    self.title = "Favorites"
    
    self.moviePageView.movieTableView.delegate = self
    self.moviePageView.movieTableView.dataSource = self
    
    presenter.loadingFavoriteDelegate = self
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.getFavoriteMovies()
  }
}

extension FavoritePageController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favoriteMovies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MovieTableViewCell {
      cell.configureCell(movie: favoriteMovies[indexPath.row])
      return cell
    }
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    presenter.goToDetailPage(from: self, withMovieModel: favoriteMovies[indexPath.row])
  }
  
}

extension FavoritePageController: LoadingMovieDelegate {
  func loadingView(isLoading: Bool) {
    self.moviePageView.setupLoadingView(isLoading: isLoading)
  }
  
  func getErrorMessage(errorMessage: String?) {
    print(errorMessage!)
  }
  
  func setMovie(movies: [MovieModel]) {
    self.favoriteMovies = movies
    self.moviePageView.movieTableView.reloadData()
  }
  
  func noData() {
    self.moviePageView.setupNoDataState()
  }
}
