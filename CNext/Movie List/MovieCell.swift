//
//  MovieCell.Swift
//  CNext
//
//  Created by Pedro Bandeira on 06/01/19.
//  Copyright © 2019 Pedro Bandeira. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    var genre: String?{
        didSet{
            movieGenreLabel.text = genre ?? ""
        }
    }
    
    var movie: Movie? {
        didSet{
            moviePoster.setImageFromUrl(imageURL: (movie?.posterURL)!)
            movieNameLabel.text = movie?.title ?? ""
            movieDateLabel.text = "Release date: \(movie?.release_date ?? "")"
        }
    }
}
