//
//  HeaderCollectionView.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 19/08/21.
//

import UIKit

class HeaderCollectionView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setupCell(title: String) {
        titleLabel.text = title
    }
}
