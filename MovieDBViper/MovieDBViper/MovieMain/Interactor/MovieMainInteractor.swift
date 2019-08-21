//
//  MovieMainInteractor.swift
//  MovieDBViper
//
//  Created Pedro Enrique Sobrosa Lopes on 14/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import Foundation

/// MovieMain Module Interactor
class MovieMainInteractor: MovieMainInteractorProtocol {
    
    typealias CoverCompletionBlock = ( _ data: Data?, _ error: Error?) -> Void
    
    func isConnectedToNetwork() -> Bool {
        return WebService.sharedService.isConnectedToNetwork()
    }
    
    func getPopularMovies(presenter: MovieMainPresenterProtocol) {
        WebService.sharedService.getPopularMovies { popularMovies, error in
            if let error = error {
                presenter.popularMoviesDidFetch(popularMovies: nil, error: error)
            }
            else if let popularMovies = popularMovies {
                var movies: [Movie] = []
                popularMovies.results?.forEach {
                    let data = WebService.sharedService.getCoverFrom(posterPath: $0.posterPath)
                    if data != nil {
                        movies.append(Movie(id: $0.id, coverData: data, title: $0.title, ratings: $0.voteAverage, overview: $0.overview))
                    }
                }
                presenter.popularMoviesDidFetch(popularMovies: movies, error: nil)
            }
        }
    }
    
    func getNowPlayingMovies(presenter: MovieMainPresenterProtocol) {
        WebService.sharedService.getNowPlayingMovies { nowPlayingMovies, error in
            if let error = error {
                presenter.nowPlayingMoviesDidFetch(nowPlayingMovies: nil, error: error)
            }
            else if let nowPlayingMovies = nowPlayingMovies {
                var movies: [Movie] = []
                nowPlayingMovies.results?.forEach {
                    let data = WebService.sharedService.getCoverFrom(posterPath: $0.posterPath)
                    if data != nil {
                        movies.append(Movie(id: $0.id, coverData: data, title: $0.title, ratings: $0.voteAverage, overview: $0.overview))
                    }
                }
                presenter.nowPlayingMoviesDidFetch(nowPlayingMovies: movies, error: nil)
            }
        }
    }

}
