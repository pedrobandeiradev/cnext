//
//  MovieDetailsViewController.swift
//  CNext
//
//  Created by Pedro Bandeira on 06/01/19.
//  Copyright © 2019 Pedro Bandeira. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    
    var _title: String?
    var _date: String?
    var _genre: String?
    var _overview: String?
    var _posterURL: URL?
    var genre: String?
    
    var selectedMovie: Movie? {
        didSet{
            _posterURL = selectedMovie?.posterURL
            _title = selectedMovie?.title ?? ""
            _genre = genre
            _date = selectedMovie?.release_date ?? ""
            _overview = selectedMovie?.overview ?? ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovieInfo()
    }
    
    private func loadMovieInfo(){
        moviePoster.setImageFromUrl(imageURL: (_posterURL)!)
        movieTitleLabel.text =  _title
        movieGenreLabel.text = _genre
        movieDateLabel.text = _date
        overviewTextView.text = _overview
    }
}
