//
//  MovieCollectionViewCell.swift
//  CodeTestEmmanuelCepeda
//
//  Created by Juan Cepeda on 4/5/19.
//  Copyright © 2019 Juan Cepeda. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView?
    
    override func awakeFromNib() {
        self.movieImageView!.clipsToBounds = true
    }
    
}
