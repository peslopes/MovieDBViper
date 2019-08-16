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
    private var popularMovies: [Movie]?
    private var nowPlayingMovies: [Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        tableView.dataSource = self
        presenter = MovieMainPresenter(view: self)
        
        // Informs the Presenter that the View is ready to receive data.
        presenter.fetch(objectFor: self)
    }
    
}

// MARK: - extending MovieMainView to implement it's protocol
extension MovieMainView: MovieMainViewProtocol {
    func set(nowPlayingMovies: [Movie]) {
        self.nowPlayingMovies = nowPlayingMovies
    }
    
    func set(popularMovies: [Movie]) {
        self.popularMovies = popularMovies
    }
    
    
}

extension MovieMainView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return popularMovies?.count ?? 0
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "nowPlayingTableViewCell", for: indexPath) as? NowPlayingTableViewCell{
                cell.nowPlayingCollectionView.dataSource = self
                return cell
            }
        }
        else if indexPath.section == 1 {
            return tableView.dequeueReusableCell(withIdentifier: "PopularMovieLabelCell", for: indexPath)
        }
        
        else if indexPath.section == 2 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "popularMoviesTableViewCell", for: indexPath) as? PopularMoviesTableViewCell {
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
}

extension MovieMainView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowPlayingMovies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nowPlayingCollectionViewCell", for: indexPath) as? NowPlayingCollectionViewCell {
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
}
