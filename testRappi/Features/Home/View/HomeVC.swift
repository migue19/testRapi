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
    var movies: [MoviesResponseEntity] = []
    var sections: [TypeMovieV3] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    private func getData() {
        presenter?.getInformation()
    }
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: GroupCollectionCell.identifier, bundle: nil), forCellWithReuseIdentifier: GroupCollectionCell.identifier)
        collectionView.register(UINib(nibName: HeaderCollectionView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionView.identifier)
        getData()
    }
}
/// Protocolo para recibir datos de presenter.
extension HomeVC: HomeViewProtocol {
    func showMovies(data: [MoviesResponseEntity]) {
        self.movies = data
        self.sections = data.compactMap({ $0.section })
        self.collectionView.reloadData()
    }
}
extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalespace: CGFloat = 16 * 3
        let width = UIScreen.main.bounds.width - totalespace
        return CGSize(width: width, height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionView.identifier, for: indexPath) as? HeaderCollectionView else {
            return UICollectionReusableView()
        }
        let title = sections[indexPath.section].title
        header.setupCell(title: title)
        return header
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupCollectionCell.identifier, for: indexPath) as? GroupCollectionCell else { return UICollectionViewCell() }
        let currentSection = sections[indexPath.section]
        let movies = getMoviesFor(section: currentSection)
        cell.setupCell(data: movies)
        return cell
    }
}
extension HomeVC {
    func getMoviesFor(section: TypeMovieV3) -> [MovieListDetail] {
        if let data = movies.filter({ $0.section == section }).first, let movies = data.movies {
            return movies.results
        } else {
            return [MovieListDetail]()
        }
    }
}
