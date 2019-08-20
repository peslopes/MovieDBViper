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
    private var numberOfSections = 0
    private var nowPlayingMoviesSection = 0
    private var popularLabelSection = 1
    private var popularMoviesSection = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        self.tableView.dataSource = self
        self.tableView.delegate = self
        presenter = MovieMainPresenter(view: self)
        presenter.viewDidLoad()
    }
    
    @IBAction func seeAllTouched(_ sender: UIButton) {
       presenter.showAll(nowPlayingMovies: nowPlayingMovies!, from: self)
    }
}

// MARK: - extending MovieMainView to implement it's protocol
extension MovieMainView: MovieMainViewProtocol {
    
    func set(numberOfSections: Int) {
        self.numberOfSections = numberOfSections
        if numberOfSections == 3 {
            nowPlayingMoviesSection = 0
            popularLabelSection = 1
            popularMoviesSection = 2
        }
        else if numberOfSections == 2 {
            nowPlayingMoviesSection = -1
            popularLabelSection = 0
            popularMoviesSection = 1
        }
        else {
            nowPlayingMoviesSection = -1
            popularLabelSection = -1
            popularMoviesSection = -1
            self.numberOfSections = 0
        }
    }
    
    func set(nowPlayingMovies: [Movie]) {
        DispatchQueue.main.async {
            self.nowPlayingMovies = nowPlayingMovies
        }
    }
    
    func set(popularMovies: [Movie]) {
        DispatchQueue.main.async {
            self.popularMovies = popularMovies
        }
    }
    
    func loadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
}

extension MovieMainView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == popularMoviesSection {
            return popularMovies?.count ?? 0
        }
        else if section == popularLabelSection {
            return popularMovies?.count ?? 0 > 0 ? 1 : 0
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        if indexPath.section == nowPlayingMoviesSection {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "nowPlayingTableViewCell", for: indexPath) as? NowPlayingTableViewCell{
                cell.nowPlayingCollectionView.dataSource = self
                cell.nowPlayingCollectionView.delegate = self
                cell.nowPlayingCollectionView.reloadData()
                return cell
            }
        }
        else if indexPath.section == popularLabelSection {
            return tableView.dequeueReusableCell(withIdentifier: "PopularMovieLabelCell", for: indexPath)
        }
        
        else if indexPath.section == popularMoviesSection {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "popularMoviesTableViewCell", for: indexPath) as? PopularMoviesTableViewCell {
                cell.movieRating.text = popularMovies![indexPath.row].ratings?.description
                cell.movieDescription.text = popularMovies![indexPath.row].overview
                cell.movieTitle.text = popularMovies![indexPath.row].title
                cell.movieCover.image = UIImage(data: popularMovies![indexPath.row].coverData!)
                cell.movieCover.layer.cornerRadius = 10
                return cell
            }
        }
        
        return UITableViewCell()
    }
}

extension MovieMainView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if nowPlayingMovies?.count ?? 0 < 5 {
            return nowPlayingMovies?.count ?? 0
        }
        else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nowPlayingCollectionViewCell", for: indexPath) as? MoviesCollectionViewCell {
            cell.movieCover.image = UIImage(data: nowPlayingMovies![indexPath.row].coverData!)
            cell.movieCover.layer.cornerRadius = 10
            cell.movieRating.text = nowPlayingMovies![indexPath.row].ratings?.description
            cell.movieTitle.text = nowPlayingMovies![indexPath.row].title
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension MovieMainView: UICollectionViewDelegate, UITableViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.showMovieDetails(with: nowPlayingMovies![indexPath.row], from: self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showMovieDetails(with: popularMovies![indexPath.row], from: self)
    }
}
