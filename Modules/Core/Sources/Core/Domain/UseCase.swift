//
//  File.swift
//  
//
//  Created by Aji Saputra Raka Siwi on 14/02/21.
//

import Combine

public protocol UseCase {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
