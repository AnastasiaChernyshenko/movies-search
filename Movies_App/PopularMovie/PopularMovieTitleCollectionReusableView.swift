//
//  PopularMovieTitleCollectionReusableView.swift
//  Movies_App
//
//  Created by Anastasia on 15.02.2021.
//

import UIKit

class PopularMovieTitleCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "PopularMovieTitleCollectionReusableView"
    
    private let title: UILabel = {
        let title = UILabel()
        title.text = "Popular Movies"
        title.font = .boldSystemFont(ofSize: 21)
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        title.layer.frame = CGRect(x: 20, y: 10, width: 150, height: 40)
    }
    
}
