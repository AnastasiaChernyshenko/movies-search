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
        guard let url = URL(string: ExternalLinks.forImage+movie.poster) else { return}
        imageOfPopularMovie.loadURL(url)

    }
}
