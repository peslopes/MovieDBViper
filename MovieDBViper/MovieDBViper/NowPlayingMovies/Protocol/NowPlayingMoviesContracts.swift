//
//  NowPlayingMoviesContracts.swift
//  MovieDBViper
//
//  Created Pedro Enrique Sobrosa Lopes on 19/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import UIKit

//MARK: View -
/*
 Should replace "class" with "BaseViewProtocol" if available;
 & that will allow the View to act as a UIViewController;
 & Implement common view functions.
 */
/// NowPlayingMovies Module View Protocol
protocol NowPlayingMoviesViewProtocol: class {
    // Update UI with value returned.
    func set(movies: [Movie])
}

//MARK: Interactor -
/// NowPlayingMovies Module Interactor Protocol
protocol NowPlayingMoviesInteractorProtocol {
}

//MARK: Presenter -
/// NowPlayingMovies Module Presenter Protocol
protocol NowPlayingMoviesPresenterProtocol {
    func viewDidLoad()

}

//MARK: Router (aka: Wireframe) -
/// NowPlayingMovies Module Router Protocol
protocol NowPlayingMoviesRouterProtocol {
    // Show Details of Entity Object coming from ParentView Controller.
    // func showDetailsFor(object: NowPlayingMoviesEntity, parentViewController viewController: UIViewController)
}
