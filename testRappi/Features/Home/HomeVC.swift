//
//  HomeVC.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 20/07/21.
//

import UIKit
import WebKit
class HomeVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var presenter: HomePresenterProtocol?
    var dataSource: [MovieListDetail] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "The MovieDB"
        setupCollectionView()
    }
    private func getData() {
        presenter?.getInformation()
    }
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "MoviesCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MoviesCollectionCell")
        getData()
    }
}
/// Protocolo para recibir datos de presenter.
extension HomeVC: HomeViewProtocol {
    func showPopularMovies(data: MovieListResponse) {
        self.dataSource = data.results
        self.collectionView.reloadData()
    }
}
extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalespace: CGFloat = 16 * 3
        let width = UIScreen.main.bounds.width - totalespace
        return CGSize(width: width/2, height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionCell", for: indexPath) as? MoviesCollectionCell else { return UICollectionViewCell() }
        cell.setupCell(data: dataSource[indexPath.row])
        return cell
    }
}
