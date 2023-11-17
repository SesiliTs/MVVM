//
//  HomeViewModel.swift
//  22.API
//
//  Created by Sesili Tsikaridze on 17.11.23.
//

import Foundation

class HomeViewModel {
    private var itemModel: Movie
    
    var movieTitle: String {
        itemModel.originalTitle
    }
    
    var movieDescription: String {
        itemModel.overview
    }
    
    var moviePoster: String {
        itemModel.posterPath
    }
    
    var movieRating: Double {
        itemModel.voteAverage
    }
    
    var movieDate: String {
        return itemModel.releaseDate
    }
    
    var isLoading: Bool = false
    var movies: [Movie] = []
    private let url = "https://api.themoviedb.org/3/movie/popular?api_key=0121a87cc86615dcfff388722ec6de80"

    var onFetchMovies: (() -> Void)?

    init(itemModel: Movie) {
        self.itemModel = itemModel
    }

    func fetchMovies() {
        isLoading = true
        
        NetworkService.shared.getData(urlString: url) { [weak self] (result: Result<MovieResponse, Error>) in
            guard let self = self else { return }

            switch result {
            case .success(let data):
                self.movies = data.results
                self.isLoading = false
                self.onFetchMovies?()

            case .failure(let error):
                print(error.localizedDescription)
                self.isLoading = false
            }
        }
    }


}
