//
//  GroupCollectionCell.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 21/08/21.
//

import UIKit

class GroupCollectionCell: UICollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: [MovieListDetail] = []
    static let identifier = String(describing: GroupCollectionCell.self)
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: MoviesCollectionCell.identifier, bundle: nil), forCellWithReuseIdentifier: MoviesCollectionCell.identifier)
    }
    func setupCell(data: [MovieListDetail]) {
        dataSource = data
        collectionView.reloadData()
    }
}
extension GroupCollectionCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpace: CGFloat = 8 * 3
        let width = bounds.width - totalSpace
        return CGSize(width: width/2, height: bounds.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
}
extension GroupCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionCell.identifier, for: indexPath) as? MoviesCollectionCell else { return UICollectionViewCell() }
        cell.setupCell(data: dataSource[indexPath.row])
        return cell
    }
}
