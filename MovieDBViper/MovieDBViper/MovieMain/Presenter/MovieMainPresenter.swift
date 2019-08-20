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
    private var nowPlayingRequestError = false
    private var popularRequestError = false
    private var nowPlayingRequestReady = false
    
    init(view: MovieMainViewProtocol) {
        self._view = view
        self.interactor = MovieMainInteractor()
        self.wireframe = MovieMainRouter()
    }
    
    func showMovieDetails(with movie: Movie, from view: UIViewController) {
        wireframe.pushToMovieDetails(with: movie, from: view)
    }
    
    func showAll(nowPlayingMovies: [Movie], from view: UIViewController) {
        wireframe.pushToAllNowPlayingMovies(with: nowPlayingMovies, from: view)
    }

    func viewDidLoad() {
        self.loadMovieLists()
    }
    
    func loadMovieLists() {
        interactor.getNowPlayingMovies(presenter: self)
        interactor.getPopularMovies(presenter: self)
    }
    
    func popularMoviesDidFetch(popularMovies: [Movie]?, error: Error?) {
        if error != nil || popularMovies?.isEmpty ?? true{
            popularRequestError = true
        }
        else {
            if !nowPlayingRequestReady {
                _view?.set(numberOfSections: 2)
            }
            let movies = popularMovies!.sorted(by: {$0.ratings! > $1.ratings! })
            _view?.set(popularMovies: movies)
            _view?.loadData()
        }
    }
    
    func nowPlayingMoviesDidFetch(nowPlayingMovies: [Movie]?, error: Error?) {
        if error != nil || nowPlayingMovies?.isEmpty ?? true{
            nowPlayingRequestError = true
            _view?.set(numberOfSections: 2)
        }
        else {
            _view?.set(numberOfSections: 3)
            _view?.set(nowPlayingMovies: nowPlayingMovies!)
            _view?.loadData()
        }
        nowPlayingRequestReady = true
    }
    
    func totalError() -> Bool {
        return popularRequestError && nowPlayingRequestError
    }
    
}
