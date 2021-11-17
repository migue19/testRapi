//
//  SearchVC.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 28/08/21.
//

import UIKit

class SearchVC: BaseController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: [MovieListDetail] = []
    var presenter: SearchPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    func setupCollectionView() {
        searchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: MoviesCollectionCell.identifier, bundle: nil), forCellWithReuseIdentifier: MoviesCollectionCell.identifier)
    }
}
/// Protocolo para recibir datos de presenter.
extension SearchVC: SearchViewProtocol {
    func showMovies(data: [MovieListDetail]) {
        dataSource = data
        collectionView.reloadData()
    }
}
extension SearchVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            dataSource = []
            collectionView.reloadData()
            return
        }
        presenter?.getMoviesBy(query: text)
    }
}
extension SearchVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpace: CGFloat = 8 * 4
        let width = view.bounds.width - totalSpace
        return CGSize(width: width/2, height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
}
extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionCell.identifier, for: indexPath) as? MoviesCollectionCell else { return UICollectionViewCell() }
        cell.setupCell(data: dataSource[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = dataSource[indexPath.row]
        presenter?.pressDetail(movie: data)
    }
}
