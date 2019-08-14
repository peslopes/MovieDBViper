//
//  MovieMainView.swift
//  MovieDBViper
//
//  Created Pedro Enrique Sobrosa Lopes on 14/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import UIKit

/// MovieMain Module View
class MovieMainView: UIViewController {
    
    private let ui = MovieMainViewUI()
    private var presenter: MovieMainPresenterProtocol!
    
    private var object : MovieMainEntity?
    
    override func loadView() {
        // setting the custom view as the view controller's view
        ui.delegate = self
        ui.dataSource = self
        view = ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MovieMainPresenter(view: self)
        
        // Informs the Presenter that the View is ready to receive data.
        presenter.fetch(objectFor: self)
    }
    
}

// MARK: - extending MovieMainView to implement it's protocol
extension MovieMainView: MovieMainViewProtocol {
    func set(object: MovieMainEntity) {
        <#code#>
    }
    
    
}

// MARK: - extending MovieMainView to implement the custom ui view delegate
extension MovieMainView: MovieMainViewUIDelegate {
    
}

// MARK: - extending MovieMainView to implement the custom ui view data source
extension MovieMainView: MovieMainViewUIDataSource {
    func objectFor(ui: MovieMainViewUI) -> MovieMainEntity {
        <#code#>
    }
    
    // Pass the pre-defined object to the dataSource.
}
