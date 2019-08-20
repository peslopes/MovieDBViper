//
//  ShowMoviesInteractor.swift
//  MovieDBViper
//
//  Created Pedro Enrique Sobrosa Lopes on 20/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import UIKit

/// ShowMovies Module Interactor
class ShowMoviesInteractor: ShowMoviesInteractorProtocol {
    func search(text: String, presenter: ShowMoviesPresenterProtocol) {
        WebService.sharedService.search(text: text) { data, error in
            if let error = error {
                presenter.searchDidFetch(movies: nil, error: error)
            }
            else if let data = data {
                var movies: [Movie] = []
                data.results?.forEach {
                    let data = WebService.sharedService.getCoverFrom(posterPath: $0.posterPath)
                    if data != nil {
                        movies.append(Movie(id: $0.id, coverData: data, title: $0.title, ratings: $0.voteAverage, overview: $0.overview))
                    }
                }
                presenter.searchDidFetch(movies: movies, error: nil)
            }
        }
    }
}
