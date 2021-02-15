//
//  File.swift
//  
//
//  Created by Aji Saputra Raka Siwi on 14/02/21.
//

import Combine

public protocol LocaleDataSource {
  associatedtype Request
  associatedtype Response
  
  func getAllResponse() -> AnyPublisher<Response, Error>
  func getResponse(request: Request) -> AnyPublisher<Bool, Error>
  func addToLocale(request: Request) -> AnyPublisher<Bool, Error>
  func deleteFromLocale(request: Request) -> AnyPublisher<Bool, Error>
}
