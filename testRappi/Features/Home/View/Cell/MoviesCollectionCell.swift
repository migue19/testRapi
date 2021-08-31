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
    }
    func setupCell(data: MovieListDetail) {
        if let posterPath = data.posterPath {
            let image = TMDb.imageUrlBase + posterPath
            imageView.downloadImageFrom(urlString: image, imageMode: .scaleAspectFill)
        } else {
            imageView.image = UIImage(named: "image_not_found")
        }
        titleLabel.text = data.title
    }
}
