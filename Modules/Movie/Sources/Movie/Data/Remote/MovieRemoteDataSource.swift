//
//  File.swift
//  
//
//  Created by Aji Saputra Raka Siwi on 15/02/21.
//

import Foundation
import Combine
import Core

public final class MovieRemoteDataSource {
  let request: Request
  
  public init(request: Request) {
    self.request = request
  }
}

extension MovieRemoteDataSource: DataSource {
  public typealias Request = String
  public typealias Response = [MovieResultResponse]
  
  public func execute(request: String?) -> AnyPublisher<[MovieResultResponse], Error> {
    return Future<[MovieResultResponse], Error> { completion in
      var urlComponent = URLComponents()
      urlComponent.scheme = "https"
      urlComponent.host = MovieDbUrl.host
      if let query = request {
        urlComponent.path = MovieDbUrl.searchMoviePath
        urlComponent.queryItems = [
          URLQueryItem(name: "api_key", value: Utils.getApiKey()),
          URLQueryItem(name: "language", value: "en"),
          URLQueryItem(name: "query", value: query),
          URLQueryItem(name: "page", value: "1")
        ]
      } else {
        urlComponent.path = MovieDbUrl.getMoviePath
        urlComponent.queryItems = [
          URLQueryItem(name: "api_key", value: Utils.getApiKey()),
          URLQueryItem(name: "language", value: "en"),
          URLQueryItem(name: "page", value: "1")
        ]
      }
      
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
