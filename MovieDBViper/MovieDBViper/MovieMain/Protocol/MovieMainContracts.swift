//
//  MovieMainContracts.swift
//  MovieDBViper
//
//  Created Pedro Enrique Sobrosa Lopes on 14/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import UIKit

//MARK: View -
/*
 Should replace "class" with "BaseViewProtocol" if available;
 & that will allow the View to act as a UIViewController;
 & Implement common view functions.
 */
/// MovieMain Module View Protocol
protocol MovieMainViewProtocol: BaseViewProtocol {
    // Update UI with value returned.
    /// Set the view Object of Type Movie
    func set(popularMovies: [Movie])
    
    func set(nowPlayingMovies: [Movie])
}

//MARK: Interactor -
/// MovieMain Module Interactor Protocol
protocol MovieMainInteractorProtocol {
    // Fetch Object from Data Layer
    func getPopularMovies(presenter: MovieMainPresenterProtocol)
    
    func getNowPlayingMovies(presenter: MovieMainPresenterProtocol)
}

//MARK: Presenter -
/// MovieMain Module Presenter Protocol
protocol MovieMainPresenterProtocol {
    func viewDidLoad()
    
    func loadMovieLists()

    func popularMoviesDidFetch(popularMovies: [Movie]?, error: Error?)
    
    func nowPlayingMoviesDidFetch(nowPlayingMovies: [Movie]?, error: Error?)
}

//MARK: Router (aka: Wireframe) -
/// MovieMain Module Router Protocol
protocol MovieMainRouterProtocol {
    // Show Details of Entity Object coming from ParentView Controller.
    // func showDetailsFor(object: Movie, parentViewController viewController: UIViewController)
}
