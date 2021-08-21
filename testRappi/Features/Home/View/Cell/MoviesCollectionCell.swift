//
//  MoviesCollectionCell.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 30/07/21.
//

import UIKit
import NutUtils
final class MoviesCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imageView: ImageLoader!
    @IBOutlet weak var titleLabel: UILabel!
    static let identifier = String(describing: MoviesCollectionCell.self)
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
