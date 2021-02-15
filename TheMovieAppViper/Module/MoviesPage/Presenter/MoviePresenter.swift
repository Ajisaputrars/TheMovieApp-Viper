import UIKit
import Combine
import Movie
import Core

class MoviePresenter<Request, Response, Interactor: UseCase> where Interactor.Request == Request, Interactor.Response == [MovieModel]  {
  private let movieUseCase: Interactor
  private var cancellables: Set<AnyCancellable> = []
  weak var loadingMealDelegate: LoadingMovieDelegate?

  init(movieUseCase: Interactor) {
    self.movieUseCase = movieUseCase
  }
  
  func getMovies(withQuery query: Request? = nil) {
    self.loadingMealDelegate?.loadingView(isLoading: true)
    self.movieUseCase.execute(request: query)
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
    MovieRouter().goToDetailPage(from: controller, withMovieModel: movie)
  }
}

protocol LoadingMovieDelegate: class {
  func loadingView(isLoading: Bool)
  func getErrorMessage(errorMessage: String?)
  func setMovie(movies: [MovieModel])
  func noData()
}
