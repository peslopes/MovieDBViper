//
//  MovieMainPresenter.swift
//  MovieDBViper
//
//  Created Pedro Enrique Sobrosa Lopes on 14/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import UIKit

/// MovieMain Module Presenter
class MovieMainPresenter: MovieMainPresenterProtocol {
    
    weak private var _view: MovieMainViewProtocol?
    private var interactor: MovieMainInteractorProtocol
    private var wireframe: MovieMainRouterProtocol
    
    
    init(view: MovieMainViewProtocol) {
        self._view = view
        self.interactor = MovieMainInteractor()
        self.wireframe = MovieMainRouter()
    }

    func viewDidLoad() {
        self.loadMovieLists()
    }
    
    func loadMovieLists() {
        interactor.getPopularMovies(presenter: self)
        interactor.getNowPlayingMovies(presenter: self)
    }
    
    func popularMoviesDidFetch(popularMovies: [Movie]?, error: Error?) {
        let movies = popularMovies!.sorted(by: {$0.ratings! > $1.ratings! })
        _view?.set(popularMovies: movies)
    }
    
    func nowPlayingMoviesDidFetch(nowPlayingMovies: [Movie]?, error: Error?) {
        _view?.set(nowPlayingMovies: nowPlayingMovies!)
    }
    
}
