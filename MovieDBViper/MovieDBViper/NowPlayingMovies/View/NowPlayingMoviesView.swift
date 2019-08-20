//
//  NowPlayingMoviesView.swift
//  MovieDBViper
//
//  Created Pedro Enrique Sobrosa Lopes on 19/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import UIKit

/// NowPlayingMovies Module View
class NowPlayingMoviesView: UIViewController {
    
    var presenter: NowPlayingMoviesPresenterProtocol!
    
    private var object : NowPlayingMoviesEntity?
    
    @IBOutlet weak var moviesCollection: UICollectionView!
    
    var movies: [Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
}

// MARK: - extending NowPlayingMoviesView to implement it's protocol
extension NowPlayingMoviesView: NowPlayingMoviesViewProtocol {
    func set(movies: [Movie]) {
        self.movies = movies
        moviesCollection.dataSource = self
    }
}

extension NowPlayingMoviesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = moviesCollection.dequeueReusableCell(withReuseIdentifier: "moviesViewCell", for: indexPath) as? MoviesCollectionViewCell {
            cell.movieCover.image = UIImage(data: movies![indexPath.row].coverData!)
            cell.movieCover.layer.cornerRadius = 10
            cell.movieRating.text = movies![indexPath.row].ratings?.description
            cell.movieTitle.text = movies![indexPath.row].title
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
}


