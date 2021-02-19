//
//  PopularMovieCollectionViewCell.swift
//  Movies_App
//
//  Created by Anastasia on 15.02.2021.
//

import UIKit

class PopularMovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PopularMovieCollectionViewCell"
    
    private weak var viewModel: MovieModel?
    
    @IBOutlet weak var imageOfPopularMovie: UIImageView!    
    
    public func configure(with movie: MovieModel){
        viewModel = movie
        viewModel?.loadImage { [weak self] image in
          guard let image = image else { return }
            self?.imageOfPopularMovie.image = image
        }

    }
}
