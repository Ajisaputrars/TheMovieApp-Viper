//
//  ViewController.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 29/01/21.
//

import UIKit
import Movie
import Core

class MoviePageController: UIViewController {
  private lazy var moviePageView = MoviePageView(frame: self.view.frame)
  private var movies: [MovieModel] = []
  private let moviePresenter: MoviePresenter<String, MovieModel, Interactor<String, [MovieModel], GetMoviesRepository<MovieLocaleDataSource, MovieRemoteDataSource>>>
  
  init(presenter: MoviePresenter<String, MovieModel, Interactor<String, [MovieModel], GetMoviesRepository<MovieLocaleDataSource, MovieRemoteDataSource>>>) {
    self.moviePresenter = presenter
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view = self.moviePageView
    self.title = "Movies"
    
    self.moviePageView.movieTableView.delegate = self
    self.moviePageView.movieTableView.dataSource = self
    self.moviePresenter.loadingMealDelegate = self

    self.moviePresenter.getMovies()
  }
}

extension MoviePageController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.movies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MovieTableViewCell {
      cell.configureCell(movie: self.movies[indexPath.row])
      return cell
    }
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    MovieRouter().goToDetailPage(from: self, withMovieModel: movies[indexPath.row])
  }
  
}

extension MoviePageController: LoadingMovieDelegate {
  func loadingView(isLoading: Bool) {
    self.moviePageView.setupLoadingView(isLoading: isLoading)
  }
  
  func getErrorMessage(errorMessage: String?) {
    print(errorMessage!)
  }
  
  func setMovie(movies: [MovieModel]) {
    self.movies = movies
    self.moviePageView.movieTableView.reloadData()
  }
  
  func noData() {
    self.moviePageView.setupNoDataState()
  }
  
}
