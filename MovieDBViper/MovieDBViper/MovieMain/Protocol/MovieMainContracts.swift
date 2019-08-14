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
    /// Set the view Object of Type MovieMainEntity
    func set(object: MovieMainEntity)
}

//MARK: Interactor -
/// MovieMain Module Interactor Protocol
protocol MovieMainInteractorProtocol {
    // Fetch Object from Data Layer
    func fetch(objectFor presenter: MovieMainPresenterProtocol)
}

//MARK: Presenter -
/// MovieMain Module Presenter Protocol
protocol MovieMainPresenterProtocol {
    /// The presenter will fetch data from the Interactor thru implementing the Interactor fetch function.
    func fetch(objectFor view: MovieMainViewProtocol)
    /// The Interactor will inform the Presenter a successful fetch.
    func interactor(_ interactor: MovieMainInteractorProtocol, didFetch object: MovieMainEntity)
    /// The Interactor will inform the Presenter a failed fetch.
    func interactor(_ interactor: MovieMainInteractorProtocol, didFailWith error: Error)
}

//MARK: Router (aka: Wireframe) -
/// MovieMain Module Router Protocol
protocol MovieMainRouterProtocol {
    // Show Details of Entity Object coming from ParentView Controller.
    // func showDetailsFor(object: MovieMainEntity, parentViewController viewController: UIViewController)
}
