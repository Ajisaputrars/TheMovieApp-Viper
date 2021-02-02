//
//  RemoteDataSource.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 02/02/21.
//

import Foundation
import Combine

protocol RemoteDataSourceProtocol: class {
  func getCategories() -> AnyPublisher<[MovieResultResponse], Error>
}

final class RemoteDataSource {
  private init() { }
  static let sharedInstance = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
  func getCategories() -> AnyPublisher<[MovieResultResponse], Error> {
    return Future<[MovieResultResponse], Error> { completion in
      guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=0df44c4b965ae567948c8749ade6c374&language=en-US&page=1") else { return }
      var request = URLRequest(url: url)
      request.httpMethod = "GET"
      request.timeoutInterval = 3
      
      URLSession.shared.dataTask(with: request) { maybeData, maybeResponse, maybeError in
        if maybeError != nil {
          completion(.failure(maybeError!))
        } else if
          let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
          do {
            let movies = try JSONDecoder().decode(MoviesResponse.self, from: data).movies
            for i in movies {
              print(i.releaseDate)
            }
            completion(.success(movies))
          } catch {
            completion(.failure(error))
          }
        }
      }.resume()
    }.eraseToAnyPublisher()
  }
}
