//
//  MoviesCollectionCell.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 30/07/21.
//

import UIKit
import NutUtils
class MoviesCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imageView: ImageLoader!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setupCell(data: MovieListDetail) {
        backgroundColor = .red
        let image = TMDb.imageUrlBase + data.posterPath
        imageView.downloadImageFrom(urlString: image, imageMode: .scaleAspectFill)
        titleLabel.text = data.title
    }
}
