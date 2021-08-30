//
//  MovieDetailVC.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 29/08/21.
//

import UIKit
import NutUtils
class MovieDetailVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageView: ImageLoader!
    @IBOutlet weak var textView: UITextView!
    var data: MovieListDetail?
    var presenter: MovieDetailPresenterProtocol?
    var videos: [VideoListDetail] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getData()
    }
    private func getData() {
        presenter?.getVideos()
    }
    private func setupView() {
        setupNavigationBar()
        setupCollectionView()
        guard let data = data else {
            return
        }
        if let posterPath = data.posterPath {
            let image = TMDb.imageUrlBase + posterPath
            imageView.downloadImageFrom(urlString: image, imageMode: .scaleAspectFill)
        }
        self.title = data.title
        textView.text = data.overview
    }
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: VideoCollectionCell.identifier, bundle: nil), forCellWithReuseIdentifier: VideoCollectionCell.identifier)
    }
    private func setupNavigationBar() {
        setCloseNavigationItem()
        self.navigationController?.navigationBar.standardAppearance.largeTitleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20)]
        self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20)]
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
extension MovieDetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpace: CGFloat = 16 * 4
        let width = view.frame.width - totalSpace
        return CGSize(width: width, height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
}
extension MovieDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionCell.identifier, for: indexPath) as? VideoCollectionCell else { return UICollectionViewCell() }
        cell.setupCell(data: videos[indexPath.row])
        return cell
    }
}
/// Protocolo para recibir datos de presenter.
extension MovieDetailVC: MovieDetailViewProtocol {
    func showVideos(data: [VideoListDetail]) {
        self.videos = data
        collectionView.reloadData()
    }
}
