//
//  VideoCollectionCell.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 29/08/21.
//

import UIKit
import youtube_ios_player_helper
class VideoCollectionCell: UICollectionViewCell {
    @IBOutlet weak var videoContainer: YTPlayerView!
    @IBOutlet weak var titleLabel: UILabel!
    static let identifier = String(describing: VideoCollectionCell.self)
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.clipsToBounds = true
        self.videoContainer.layer.cornerRadius = 8
    }
    func setupCell(data: VideoListDetail) {
        self.titleLabel.text = data.name
        self.videoContainer.load(withVideoId: data.key)
    }
}
