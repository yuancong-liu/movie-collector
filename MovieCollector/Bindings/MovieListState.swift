//
//  MovieListState.swift
//  MovieCollector
//
//  Created by YUAN-TSUNG LIOU on 2022/1/10.
//

import Foundation

class MovieListState: ObservableObject {
    
    @Published var movies: [Movie]?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private let movieService: MovieService
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
    func loadMovies(with endpoint: MovieListEndpoint) {
        self.movies = nil
        self.isLoading = false
        self.movieService.fetchMovies(from: endpoint) { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
                case .success(let response):
                    self.movies = response.results
                case .failure(let error):
                    self.error = error as NSError
            }
            
        }
    }
}
