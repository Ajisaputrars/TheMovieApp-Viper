//
//  SearchPageController.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 10/02/21.
//

import UIKit
import Core
import Movie

class SearchPageController: UIViewController {
  private lazy var searchPageView = SearchPageView(frame: self.view.frame)
  private var movies: [MovieModel] = []
  private let moviePresenter: MoviePresenter
  
  init(presenter: MoviePresenter) {
    self.moviePresenter = presenter
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view = searchPageView
    title = "Search"
    searchPageView.setupNoDataState()
    
    moviePresenter.loadingMealDelegate = self
    searchPageView.movieSearchBar.delegate = self
    searchPageView.movieTableView.delegate = self
    searchPageView.movieTableView.dataSource = self
    
  }
}

extension SearchPageController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    if let text = searchBar.text {
      moviePresenter.getMovies(withQuery: text)
    }
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchBar.text == nil || searchBar.text == "" {
      searchBar.perform(#selector(self.resignFirstResponder), with: nil, afterDelay: 0)
//      movies.removeAll()
      searchPageView.setupNoDataState()
    }
  }
}

extension SearchPageController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    searchPageView.movieSearchBar.resignFirstResponder()
  }
}

extension SearchPageController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MovieTableViewCell {
      cell.configureCell(movie: movies[indexPath.row])
      return cell
    }
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    moviePresenter.goToDetailPage(from: self, withMovieModel: movies[indexPath.row])
  }
}

extension SearchPageController: LoadingMovieDelegate {
  func loadingView(isLoading: Bool) {
    searchPageView.setupLoadingView(isLoading: isLoading)
  }
  
  func getErrorMessage(errorMessage: String?) {
    print(errorMessage!)
  }
  
  func setMovie(movies: [MovieModel]) {
    self.movies = movies
    searchPageView.movieTableView.reloadData()
  }
  
  func noData() {
    searchPageView.setupNoDataState()
  }
  
}
