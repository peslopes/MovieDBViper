//
//  NowPlayingMoviesPresenter.swift
//  MovieDBViper
//
//  Created Pedro Enrique Sobrosa Lopes on 19/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import UIKit

/// NowPlayingMovies Module Presenter
class NowPlayingMoviesPresenter {
    
    weak private var _view: NowPlayingMoviesViewProtocol?
    private var interactor: NowPlayingMoviesInteractorProtocol
    private var wireframe: NowPlayingMoviesRouterProtocol
    var movies: [Movie]?
    
    init(view: NowPlayingMoviesViewProtocol, movies: [Movie]) {
        self.movies = movies
        self._view = view
        self.interactor = NowPlayingMoviesInteractor()
        self.wireframe = NowPlayingMoviesRouter()
    }
}

// MARK: - extending NowPlayingMoviesPresenter to implement it's protocol
extension NowPlayingMoviesPresenter: NowPlayingMoviesPresenterProtocol {
    func viewDidLoad() {
        _view?.set(movies: movies ?? [])
    }
}
