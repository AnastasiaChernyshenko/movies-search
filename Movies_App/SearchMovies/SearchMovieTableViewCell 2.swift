//
//  SearchMovieTableViewCell.swift
//  Movies_App
//
//  Created by Anastasia on 17.02.2021.
//

import UIKit

class SearchMovieTableViewCell: UITableViewCell {
    
    static let identifier = "SearchMovieTableViewCell"
    private weak var viewModel: MovieModel?
    
    @IBOutlet weak var movieTitelLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieRateLabel: UILabel!

    @IBOutlet weak var posterImage: UIImageView!{
        didSet{
            posterImage.dropShadow()
        }
    }
    
    @IBOutlet weak var insertView: UIView!{
        didSet{
            insertView.layer.cornerRadius = 5
            insertView.layer.masksToBounds = true
            insertView.alpha = 0.8
        }
    }
    
    public func configure(with movie: MovieModel){
        viewModel = movie
        viewModel?.loadImage { [weak self] image in
          guard let image = image else { return }
                self?.posterImage.image = image
        }
        
        movieTitelLabel.text = viewModel?.originalTitle
        movieYearLabel.text = viewModel?.releaseDate
        movieRateLabel.text = "⭐️ \(viewModel!.voteCount)"

    }

}
