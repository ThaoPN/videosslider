//
//  VideosSliderViewCell.swift
//  AkiTravel
//
//  Created by Est Rouge on 1/8/20.
//  Copyright © 2020 Aki Travel. All rights reserved.
//

import UIKit
import AVFoundation
import SDWebImage
import MMPlayerView

protocol MediaPlayerViewDelegate: class {
    func mediaPlayerView(_ mediaView: MediaPlayerView, completedItem item: MediaObject)
}

class MediaPlayerView: UIImageView, MMPlayerCoverViewProtocol {
    
    weak var playLayer: MMPlayerLayer?
    weak var delegate: MediaPlayerViewDelegate?
    
    struct Constants {
        static var getVideoPlaceHolder: URL {
            let videoPath = Bundle.main.path(forResource: "no_video", ofType: "mov")
            return URL(fileURLWithPath: videoPath!)
        }
        static let durationLimited = 3.0
    }
    
    static var playerLayer: MMPlayerLayer = {
        let l = MMPlayerLayer()
        l.cacheType = .memory(count: 20)
        l.videoGravity = AVLayerVideoGravity.resizeAspectFill
        l.autoPlay = true
        l.coverView?.isHidden = true
        l.player?.isMuted = true
        l.player?.automaticallyWaitsToMinimizeStalling = false
        l.masksToBounds = false
        return l
    }()

    var isPlay: Bool = false {
        didSet {
            if isPlay {
                // play
                play()
            } else {
                // stop
                pause()
            }
        }
    }
    
    private var media: MediaObject?
        
    func setMedia(media: MediaObject, withView view: UIImageView) {
        self.media = media
        MediaPlayerView.playerLayer.newReplace(cover: self)
        switch media.type {
        case .image:
            MediaPlayerView.playerLayer.playView = nil
            MediaPlayerView.playerLayer.set(url: URL(string: Constants.getVideoPlaceHolder.relativeString), lodDiskIfExist: true)
            self.sd_setImage(with: media.url, placeholderImage: nil, options: []) { (image, error, cacheType, url) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    view.image = image
                }
            }
        case .video:
            if let thumbnailUrl = media.thumbnailUrl {
                self.sd_setImage(with: thumbnailUrl, placeholderImage: nil, options: []) { (image, error, cacheType, url) in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            MediaPlayerView.playerLayer.playView = view
            MediaPlayerView.playerLayer.set(url: media.url, lodDiskIfExist: true)
            MediaPlayerView.playerLayer.resume()
        }
    }
    
    func resume() {
        MediaPlayerView.playerLayer.resume()
    }
    
    func invalidate() {
        MediaPlayerView.playerLayer.invalidate()
    }
    
    func seek(to time: CMTime, completionHandler: @escaping (Bool) -> Void) {
        MediaPlayerView.playerLayer.player?.seek(to: time, completionHandler: completionHandler)
    }
    
    func currentPlayer(status: PlayStatus) {
        switch status {
        case .playing:
            print("playing")
        default:
            print(status)
        }
    }
    
    func timerObserver(time: CMTime) {
        if let duration = self.playLayer?.player?.currentItem?.asset.duration,
            let media = self.media,
            !duration.isIndefinite {
            print("\(time.seconds) / \(duration.seconds)")
            if time.seconds >= Constants.durationLimited {
                invalidate()
                delegate?.mediaPlayerView(self, completedItem: media)
            }
        }
    }
    
    func handlePlayerProgess() {
//        MediaPlayerView.playerLayer.playProgress = { [weak self] progress in
//            guard let `self` = self else { return }
//            guard let esVideoView = self.stackView.arrangedSubviews[self.currentIndex] as? ESVideoView else { return }
//            if !progress.isNaN && progress > 0.0 && self.isWaitingForPlay {
//                self.isWaitingForPlay = false
//            }
//
//            if !progress.isNaN && progress > 0.0 && self.isWaitingToPlayAudio {
//                self.isWaitingToPlayAudio = false
//                SoundtrackDownloader.shared.play()
//            }
//
//            if self.player.isPlay == true && self.isWaitingToPlayAudio == false && SoundtrackDownloader.shared.isPlaying == false && progress > 0.0 {
//                SoundtrackDownloader.shared.play()
//            }
//
//            let secondInVideo = progress.isNaN ? 0 : Double(progress) * self.player.mediaDuration
//            let secondInTotal = self.timeToNextVideo * Double(self.currentIndex) + secondInVideo
//
//            if secondInVideo <= 1 && self.currentIndex > 0 {
//                esVideoView.thumbnailImageView.alpha = CGFloat(secondInVideo)
//            } else if self.timeToNextVideo - secondInVideo <= 1 && self.currentIndex != self.hightlightStories.count - 1 {
//                esVideoView.thumbnailImageView.alpha = CGFloat(self.timeToNextVideo - secondInVideo)
//            } else {
//                esVideoView.thumbnailImageView.alpha = 1.0
//            }
//
//            if self.timeToNextVideo - secondInVideo <= 2 && self.currentIndex == self.hightlightStories.count - 1 {
//                SoundtrackDownloader.shared.downVolume(downValue: Float(1 - (self.timeToNextVideo - secondInVideo) / 2))
//            }
//
//            if !secondInVideo.isNaN {
//                self.setTime(playedTime: secondInTotal)
//            }
//
//            if self.currentIndex < self.hightlightStories.count {
//                let media = self.hightlightStories[self.currentIndex].media[0]
//                if let animation = self.selectedAnimateImage[media.value] {
//                    switch animation {
//                    case .zoomIn:
//                        self.zoomInImageAnimation(scale: 0.1, second: secondInVideo, animateDuration: self.timeToNextVideo)
//                    case .zoomOut:
//                        self.zoomOutImageAnimation(scale: 0.1, second: secondInVideo, animateDuration: self.timeToNextVideo)
//                    case .rightToLeft:
//                        self.slideRightToLeftImageAnimation(second: secondInVideo, animateDuration: self.timeToNextVideo)
//                    case .leftToRight:
//                        self.slideLeftToRightImageAnimation(second: secondInVideo, animateDuration: self.timeToNextVideo)
//                    }
//                } else {
//                    self.resetImageAnimation()
//                }
//            }
//
//            if self.isSeeking == false {
//                let progressInTotal = secondInTotal / self.totalTimeOfStory
//                self.seekBar.progress = CGFloat(progressInTotal)
//                self.progressBar.progress = Float(progressInTotal)
//            }
//
//            if progress >= 1 && self.player.mediaDuration <= self.timeToNextVideo {
//                self.storyItemCompleted()
//            } else {
//                if progress.isNaN { return }
//
//                if Double(progress) * self.player.mediaDuration >= self.timeToNextVideo {
//                    switch self.player.currentPlayStatus {
//                    case .playing, .ready:
//                        self.storyItemCompleted()
//                    default:
//                        break
//                    }
//                }
//            }
//        }
    }
    
    private func pause() {
        guard let media = media else {
            return
        }
        
        if media.type == .image {
            MediaPlayerView.playerLayer.player?.pause()
        } else {
            MediaPlayerView.playerLayer.player?.pause()
        }
    }
    
    private func play() {
        guard let media = media else {
            return
        }
        
        if media.type == .image {
            MediaPlayerView.playerLayer.player?.play()
        } else {
            MediaPlayerView.playerLayer.player?.play()
        }
    }
}

class VideosSliderViewCell: UIView {
    var medias = [MediaObject]()
    lazy var contentImage: UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleAspectFill
        return imv
    }()
    private let player = MediaPlayerView()
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
        player.delegate = self
    }
    
    func show(medias: [MediaObject]) {
        self.medias = medias
        seekTo()
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
        print(media.url.relativeString)

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

extension VideosSliderViewCell: MediaPlayerViewDelegate {
    func mediaPlayerView(_ mediaView: MediaPlayerView, completedItem item: MediaObject) {
        let nextIndex = currentIndex + 1 >= medias.count ? 0 : currentIndex + 1
        seekTo(videoIndex: nextIndex)
    }
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

extension MMPlayerLayer {
    func newReplace(cover: (UIImageView & MMPlayerCoverViewProtocol)) {
        replace(cover: cover as (UIView & MMPlayerCoverViewProtocol))
    }
}
