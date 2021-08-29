//
//  MovieDetailVC.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 29/08/21.
//

import UIKit
import NutUtils
class MovieDetailVC: UIViewController {
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
    private func setupNavigationBar() {
        setCloseNavigationItem()
        self.navigationController?.navigationBar.standardAppearance.largeTitleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20)]
        self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20)]
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
/// Protocolo para recibir datos de presenter.
extension MovieDetailVC: MovieDetailViewProtocol {
    func showVideos(data: [VideoListDetail]) {
        print(data)
    }
}
