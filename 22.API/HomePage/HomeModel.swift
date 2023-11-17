import Foundation

// MARK: - Film
struct MovieResponse: Codable {
    let results: [Movie]
}

// MARK: - Result
struct Movie: Codable {
    let originalTitle, overview: String
    let posterPath, releaseDate, title: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}







