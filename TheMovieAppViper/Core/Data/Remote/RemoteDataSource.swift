//
//  RemoteDataSource.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 02/02/21.
//

import Foundation
import Combine

protocol RemoteDataSourceProtocol: class {
  func getMovies() -> AnyPublisher<[MovieResultResponse], Error>
}

final class RemoteDataSource {
  private init() { }
  static let sharedInstance = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
  func getMovies() -> AnyPublisher<[MovieResultResponse], Error> {
    return Future<[MovieResultResponse], Error> { completion in
      var urlComponent = URLComponents()
      urlComponent.scheme = "https"
      urlComponent.host = MovieDbUrl.host
      urlComponent.path = MovieDbUrl.path
      urlComponent.queryItems = [
        URLQueryItem(name: "api_key", value: Utils.getApiKey()),
        URLQueryItem(name: "language", value: "en"),
        URLQueryItem(name: "page", value: "1")
      ]
      
      guard let url = urlComponent.url else {return}
      var request = URLRequest(url: url)
      request.httpMethod = "GET"
      request.timeoutInterval = 5
      
      URLSession.shared.dataTask(with: request) { maybeData, maybeResponse, maybeError in
        if maybeError != nil {
          completion(.failure(maybeError!))
        } else if
          let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
          do {
            let movies = try JSONDecoder().decode(MoviesResponse.self, from: data).movies
            completion(.success(movies))
          } catch {
            completion(.failure(error))
          }
        }
      }.resume()
    }.eraseToAnyPublisher()
  }
}
