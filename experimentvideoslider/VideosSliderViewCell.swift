//
//  VideosSliderViewCell.swift
//  AkiTravel
//
//  Created by Est Rouge on 1/8/20.
//  Copyright © 2020 Aki Travel. All rights reserved.
//

import UIKit
import AVFoundation

class MediaPlayer {
    var isPlay: Bool = false
    
    func invalidate() {
        
    }
    
    func setMedia(media: Media, withView view: UIView) {
        
    }
    
    func resume() {
        
    }
    
    func seek(to time: CMTime, completionHandler: @escaping (Bool) -> Void) {
        
    }
    
}

class VideosSliderViewCell: UIView {
    var medias = [Media]()
    lazy var contentImage: UIImageView = {
        let imv = UIImageView()
        return imv
    }()
    private let player = MediaPlayer()
    private let durationForItem: CGFloat = 5
    private var currentIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(contentImage)
        contentImage.fillToSuperview()
    }
    
    func show(medias: [Media]) {
        self.medias = medias
    }
    
    func stop() {
        player.invalidate()
        player.isPlay = false
    }
    
    func pause(isPause: Bool, isShowCoverWhenPause: Bool = true) {
        // Purpose of this function is
        // when pass isPause = true, video player and audio player will pause
        // and when pass isPause = false the video player and audio player will
        // continue play at previous position
        
//        if isPause {
//            SoundtrackDownloader.shared.pause()
//        } else {
//            SoundtrackDownloader.shared.play()
//        }
        player.isPlay = !isPause
//        if isShowCoverWhenPause || isPause == false {
//            showCover(isShow: isPause)
//        }
//        pauseAnimation(isPause: isPause)
//        NotificationCenter.default.post(name: .PlayerState, object: nil, userInfo: ["isPlaying": true])
    }

    
    private func seekTo(videoIndex index: Int = 0, second: Double = 0, completed: (() -> ())? = nil) {
        stop()
        currentIndex = index
            
        let media = medias[currentIndex]

        player.setMedia(media: media, withView: contentImage)
//            isSeeking = true
//            self.resetImageAnimation()
            self.player.resume()
            dispatchDelayAfter(seconds: 0.1) {
                let timeSeekTo = CMTimeMakeWithSeconds(second, preferredTimescale: 100)
                self.player.seek(to: timeSeekTo, completionHandler: { (finish) in
                    print("seek finished: \(finish)")
//                    self.isSeeking = false
                    self.player.isPlay = true
//                    if !self.isMinimizing {
//                        self.showCover(isShow: false)
//                    }
//                    if !SoundtrackDownloader.shared.isPlaying {
//                        SoundtrackDownloader.shared.play()
//                    }
                    
//                    if self.convert(self.frame.origin, to: GET_KEY_WINDOW).y < 0 {
//                        guard let esVideoView = self.stackView.arrangedSubviews[self.currentIndex] as? ESVideoView else {return}
//                        esVideoView.thumbnailImageView.alpha = 0
//                        dispatchDelayAfter(seconds: 0.3) {
//                            self.pause(isPause: true, isShowCoverWhenPause: false)
//                        }
//                    }
                })
            }
        }
}

enum MediaType {
    case video, image
}
class Media {
    var type: MediaType = .image
    var url: String = ""
}


extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
