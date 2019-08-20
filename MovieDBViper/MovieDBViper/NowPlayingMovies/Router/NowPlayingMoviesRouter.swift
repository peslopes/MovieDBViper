//
//  NowPlayingMoviesRouter.swift
//  MovieDBViper
//
//  Created Pedro Enrique Sobrosa Lopes on 19/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import UIKit

/// NowPlayingMovies Module Router (aka: Wireframe)
class NowPlayingMoviesRouter: NowPlayingMoviesRouterProtocol {
    class func createNowPlayingMoviesModule(with moviesRef: NowPlayingMoviesView, and movies: [Movie]) {
        let presenter = NowPlayingMoviesPresenter(view: moviesRef, movies: movies)
        moviesRef.presenter = presenter
        //movieDetailsRef.presenter?.view = movieDetailsRef
        //        fruitDetailRef.presenter?.wireframe = FruitDetailWireFrame()
    }
}
