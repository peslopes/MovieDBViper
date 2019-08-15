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
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    private var presenter: MovieMainPresenterProtocol!
    
    private var object : MovieMainEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        presenter = MovieMainPresenter(view: self)
        
        // Informs the Presenter that the View is ready to receive data.
        presenter.fetch(objectFor: self)
    }
    
}

// MARK: - extending MovieMainView to implement it's protocol
extension MovieMainView: MovieMainViewProtocol {
    func set(object: MovieMainEntity) {
        print("Todo")
    }
    
    
}
