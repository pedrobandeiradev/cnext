//
//  MovieListViewController.Swift
//  CNext
//
//  Created by Pedro Bandeira on 06/01/19.
//  Copyright © 2019 Pedro Bandeira. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    @IBOutlet weak var noConnectionView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movieList = MovieList()
    var movies: [Movie]? {
        didSet{
            //Updates the collection when the data is loaded
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
        refreshView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsSegue" {
            let indexPath = self.collectionView.indexPathsForSelectedItems?.first
            let detailsViewController = segue.destination as! MovieDetailsViewController
            //Sends the selected movie to the details view controller
            detailsViewController.genre = self.movieList.requestGenreListForMovie(genreIDs: movies?[indexPath?.row ?? 0].genre_ids ?? [0])
            detailsViewController.selectedMovie = movies?[indexPath?.row ?? 0]
        }
    }
    
    private func refreshView() {
        noConnectionView.isHidden = true
        showLoadIndicator()
        //Updates the movie list
        movieList.getListOfMovies { (listOfMovies) in
            self.movies = listOfMovies
            self.hideLoadIndicator()
            if listOfMovies == nil {
                self.noConnectionView.isHidden = false
            }
        }
    }
    
    //If the request fails, the user can try to reload
    @IBAction func touchRetryButton(_ sender: UIButton) {
        refreshView()
    }
}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCell
        cell.movie = movies?[indexPath.item]
        cell.genre = self.movieList.requestGenreListForMovie(genreIDs: movies?[indexPath.item].genre_ids ?? [0])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailsSegue", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 128)
    }
}

