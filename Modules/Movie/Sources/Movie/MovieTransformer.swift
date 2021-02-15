import Core
import RealmSwift

public struct MovieTransformer: Mapper {
  public typealias Request = Any
  public typealias Response = [MovieResultResponse]
  public typealias Entity = [MovieEntity]
  public typealias Domain = [MovieModel]

  public func transformResponseToEntity(request: Any?, response: [MovieResultResponse]) -> [MovieEntity] {
    return response.map { result in
      let entity = MovieEntity()
      entity.id = result.id
      entity.title = result.title ?? "Unknown"
      entity.posterPath = result.posterPath ?? ""
      entity.overview = result.overview ?? "No Overview Available"
      entity.releaseDate = result.releaseDate ?? ""
      return entity
    }
  }

  public func transformEntityToDomain(entity: [MovieEntity]) -> [MovieModel] {
    return entity.map { result in
      return MovieModel(
        id: result.id,
        title: result.title,
        overview: result.overview,
        posterPath: result.posterPath,
        releaseDate: result.releaseDate
      )
    }
  }

  public func transformResponseToDomain(response: [MovieResultResponse]) -> [MovieModel] {
    return response.map { result in
      return MovieModel(
        id: result.id,
        title: result.title ?? "",
        overview: result.overview ?? "",
        posterPath: result.posterPath ?? "",
        releaseDate: result.releaseDate ?? ""
      )
    }
  }

}
