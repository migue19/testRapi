//
//  MovieDetailInteractor.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 29/08/21.
//  
//

import Foundation
import ConnectionLayer
class MovieDetailInteractor {
    var presenter: MovieDetailInteractorOutputProtocol?
    var data: MovieListDetail?
    var connectionLayer = ConnectionLayer()
}
extension MovieDetailInteractor: MovieDetailInteractorInputProtocol {
    func fetchVideos() {
        guard let data = data else {
            return
        }
        let identifier = data.identifier
        let url = TMDb.ApiV3.videos.replacingOccurrences(of: "{movie_id}", with: "\(identifier)")
        connectionLayer.conneccionRequest(url: url, method: .get, headers: [:], parameters: nil) { [weak self] (data, error) in
            guard let self = self else {
                debugPrint("self_not_found".localized)
                return
            }
            if let error = error {
                print(error)
                return
            }
            guard let data = data else {
                let error = "data_not_found".localized
                print(error)
                return
            }
            if let entity = Utils.decode(VideoList.self, from: data, serviceName: "Video Movie Service") {
                self.receiveVideos(data: entity)
            } else {
                let error = "decode_error".localized
                print(error)
            }
        }
    }
    func receiveVideos(data: VideoList) {
        DispatchQueue.main.async { [weak self] in
            self?.presenter?.sendVideos(data: data)
        }
    }
}
