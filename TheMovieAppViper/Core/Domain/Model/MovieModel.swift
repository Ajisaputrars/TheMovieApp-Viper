//
//  MovieModel.swift
//  TheMovieAppViper
//
//  Created by Aji Saputra Raka Siwi on 02/02/21.
//

import Foundation

struct MovieModel: Equatable, Identifiable {
  let id: Int
  let title: String
  let overview: String
  let posterPath: String
  let releaseDate: String
}
