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
    private var hideNowPlaying = true
    private var hidePopular = false
    private var alertHasBeenShowed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        tableView.dataSource = self
        presenter = MovieMainPresenter(view: self)
        presenter.viewDidLoad()
    }
    
}

// MARK: - extending MovieMainView to implement it's protocol
extension MovieMainView: MovieMainViewProtocol {
    func set(hideNowPlaying: Bool) {
        self.hideNowPlaying = hideNowPlaying
    }
    
    func set(hidePopular: Bool) {
        self.hidePopular = hidePopular
    }
    
    func totalRequestError() -> Bool {
       return hidePopular && hideNowPlaying
    }
    
    func set(nowPlayingMovies: [Movie]) {
        if totalRequestError() {
            if !alertHasBeenShowed {
                alertHasBeenShowed = true
                print("Todo")
            }
        }
        else {
            DispatchQueue.main.async {
                self.tableView.isHidden = false
                self.nowPlayingMovies = nowPlayingMovies
                self.tableView.reloadData()
            }
        }
    }
    
    func set(popularMovies: [Movie]) {
        if totalRequestError() {
            if !alertHasBeenShowed {
                alertHasBeenShowed = true
                print("Todo")
            }
        }
        else {
            DispatchQueue.main.async {
                self.tableView.isHidden = false
                self.popularMovies = popularMovies
                self.tableView.reloadData()
            }
        }
    }
}

extension MovieMainView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if hideNowPlaying {
            return 2
        }
        else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var popularMoviesSection = 2
        if hideNowPlaying {
            popularMoviesSection = 1
        }
        if section == popularMoviesSection {
            return popularMovies?.count ?? 0
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var popularMoviesSection = 2
        var popularMoviesLabelSection = 1
        var nowPlayingSection = 0
        if hideNowPlaying {
            popularMoviesSection = 1
            popularMoviesLabelSection = 0
            nowPlayingSection = -1
        }
        
        if indexPath.section == nowPlayingSection {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "nowPlayingTableViewCell", for: indexPath) as? NowPlayingTableViewCell{
                cell.nowPlayingCollectionView.dataSource = self
                cell.nowPlayingCollectionView.reloadData()
                return cell
            }
        }
        else if indexPath.section == popularMoviesLabelSection {
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
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nowPlayingCollectionViewCell", for: indexPath) as? NowPlayingCollectionViewCell {
            cell.movieCover.image = UIImage(data: nowPlayingMovies![indexPath.row].coverData!)
            cell.movieCover.layer.cornerRadius = 10
            cell.movieRating.text = nowPlayingMovies![indexPath.row].ratings?.description
            cell.movieTitle.text = nowPlayingMovies![indexPath.row].title
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
}
