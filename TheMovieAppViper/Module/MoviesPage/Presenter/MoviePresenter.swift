import UIKit
import Combine

class MoviePresenter {
  private let router = MovieRouter()
  private let movieUseCase: MovieUseCase
  private var cancellables: Set<AnyCancellable> = []
  weak var loadingMealDelegate: LoadingMovieDelegate?

  init(movieUseCase: MovieUseCase) {
    self.movieUseCase = movieUseCase
  }
  
  func getMovies(withQuery query: String? = nil) {
    self.loadingMealDelegate?.loadingView(isLoading: true)
    self.movieUseCase.getMovies(withQuery: query)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        self.loadingMealDelegate?.loadingView(isLoading: false)
        switch completion {
        case .failure:
          self.loadingMealDelegate?.getErrorMessage(errorMessage: String(describing: completion))
        case .finished:
          break
        }
      }, receiveValue: { movies in
        self.loadingMealDelegate?.setMovie(movies: movies)
      })
      .store(in: &cancellables)
  }
  
  func goToDetailPage(from controller: UIViewController, withMovieModel movie: MovieModel) {
    self.router.goToDetailPage(from: controller, withMovieModel: movie)
  }
}

protocol LoadingMovieDelegate: class {
  func loadingView(isLoading: Bool)
  func getErrorMessage(errorMessage: String?)
  func setMovie(movies: [MovieModel])
  func noData()
}
