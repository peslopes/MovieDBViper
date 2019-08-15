//
//  MovieMainPresenter.swift
//  MovieDBViper
//
//  Created Pedro Enrique Sobrosa Lopes on 14/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import UIKit

/// MovieMain Module Presenter
class MovieMainPresenter {
    
    weak private var _view: MovieMainViewProtocol?
    private var interactor: MovieMainInteractorProtocol
    private var wireframe: MovieMainRouterProtocol
    
    
    init(view: MovieMainViewProtocol) {
        self._view = view
        self.interactor = MovieMainInteractor()
        self.wireframe = MovieMainRouter()
    }
    
    //func load
}

// MARK: - extending MovieMainPresenter to implement it's protocol
extension MovieMainPresenter: MovieMainPresenterProtocol {
    func fetch(objectFor view: MovieMainViewProtocol) {
        print("Todo")
    }
    
    func interactor(_ interactor: MovieMainInteractorProtocol, didFetch object: MovieMainEntity) {
        print("Todo")
    }
    
    func interactor(_ interactor: MovieMainInteractorProtocol, didFailWith error: Error) {
        print("Todo")
    }
    
    
}
