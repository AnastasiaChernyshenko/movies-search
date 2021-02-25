//
//  MovieDetailViewController.swift
//  Movies_App
//
//  Created by Anastasia on 15.02.2021.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    weak var movie: MovieModel?
    var presenter: MovieDetailPresenter!
    
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var roundedView: UIView! {
        didSet {
            roundedView.layer.cornerRadius = 20
            roundedView.layer.masksToBounds = true
            roundedView.dropShadow()
        }
    }
    
    @IBOutlet weak var posterImage: UIImageView!{
            didSet {
               posterImage.dropShadow()
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewDidLoad()
        showMovieDetail()
    }
    
    func showMovieDetail(){
        guard let movie = movie else { return}
        
        movie.loadImage { [weak self] image in
            guard let image = image else {
                return}
            self?.posterImage.image = image
        }
        
        movie.loadBackdrop { [weak self] image in
            guard let image = image else { 
                return}
            self?.backdropImage.image = image
        }
        
        backdropImage.applyBlurEffect()
        titleLabel.text = movie.originalTitle
        dateLabel.text = movie.releaseDate
        voteAverageLabel.text = "⭐️ \(movie.voteAverage)"
        voteCountLabel.text = "\(movie.voteCount)"
        popularityLabel.text = "\(movie.popularity)"
        overviewLabel.text = movie.overview
    }
    
}

extension MovieDetailViewController: MovieDetailView{
    
    func detailOf(movie: MovieModel) {
        self.movie = movie
    }

}
