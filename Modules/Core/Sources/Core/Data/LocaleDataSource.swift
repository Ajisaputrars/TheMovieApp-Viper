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
  
  //    func list(request: Request?) -> AnyPublisher<[Response], Error>
  //    func add(entities: [Response]) -> AnyPublisher<Bool, Error>
  //    func get(id: String) -> AnyPublisher<Response, Error>
  //    func update(id: String, entity: Response) -> AnyPublisher<Bool, Error>
  
  func getAllResponse() -> AnyPublisher<Response, Error>
  func getResponse(request: Request) -> AnyPublisher<Bool, Error>
  func addToLocale(request: Request) -> AnyPublisher<Bool, Error>
  func deleteFromLocale(request: Request) -> AnyPublisher<Bool, Error>
}
