//
//  VideosSliderView.swift
//  AkiTravel
//
//  Created by Est Rouge on 1/8/20.
//  Copyright © 2020 Aki Travel. All rights reserved.
//

import UIKit

protocol VideosSliderViewDataSource: class {
//    func getMedias() -> [MediaObject]
    func numberOfItems() -> Int
    func videosSliderView(_ videosSliderView: VideosSliderView, index: Int) -> [MediaObject]
}

class VideosSliderView: UIView {
    weak var datasource: VideosSliderViewDataSource?
    lazy var scrollView: UIScrollView = {
        let scrView = UIScrollView()
        scrView.isPagingEnabled = true
        scrView.delegate = self
        return scrView
    }()
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var displayedView: VideosSliderViewCell? {
        if contentStackView.arrangedSubviews.isEmpty ||
            contentStackView.arrangedSubviews.count < 2 {
            return nil
        }
        return contentStackView.arrangedSubviews[1] as? VideosSliderViewCell
    }
    private let maxAngle: CGFloat = 60.0
    private var currentIndex = 0
    private var totalItems: Int {
        return datasource?.numberOfItems() ?? 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.contentOffset.x = bounds.width
        resetContentViewState()
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        self.perform(#selector(fillDataLayout), with: self, afterDelay: 0.2)
    }
    
    private func setupUI() {
        addSubview(scrollView)
        scrollView.fillToSuperview()
        
        scrollView.addSubview(contentView)
        contentView.fillToSuperview()
        contentView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        
        contentView.addSubview(contentStackView)
        contentStackView.fillToSuperview()
        
        updateLayout()
    }
    
    private func updateLayout() {
        for i in 0..<3 {
            let view = VideosSliderViewCell(frame: bounds)
            view.tag = i
            view.clipsToBounds = true
            view.backgroundColor = .random()
            contentStackView.addArrangedSubview(view)
        }
        
        contentStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: CGFloat(contentStackView.arrangedSubviews.count)).isActive = true
    }
    
    @objc func fillDataLayout() {
        if totalItems > 0 {
            if let medias = datasource?.videosSliderView(self, index: currentIndex),
                let displayedView = self.displayedView {
                displayedView.show(medias: medias)
//                for view in contentStackView.arrangedSubviews {
//                    (view as? VideosSliderViewCell)?.contentImage.sd_setImage(with: medias[0].url, completed: nil)
//                }
            }
        }
    }
    
    private func resetContentViewState() {
        for view in self.contentStackView.arrangedSubviews {
            view.transform = .identity
            view.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        }
    }
}

extension VideosSliderView: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("\(#function) \(decelerate)")
        if decelerate {
            scrollView.isScrollEnabled = false
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(#function)
        
        let page = Int(scrollView.contentOffset.x/self.bounds.width)
        switch page {
        case 0:
            // scroll to previous
            let lastView = self.contentStackView.arrangedSubviews[2]
            self.contentStackView.removeArrangedSubview(lastView)
            self.contentStackView.insertArrangedSubview(lastView, at: 0)
            self.scrollView.contentOffset.x = self.bounds.width
            resetContentViewState()
            currentIndex = currentIndex - 1 >= 0 ? currentIndex - 1 : totalItems - 1
            fillDataLayout()
        case 2:
            // scroll to next
            let firstView = self.contentStackView.arrangedSubviews[0]
            self.contentStackView.removeArrangedSubview(firstView)
            self.contentStackView.addArrangedSubview(firstView)
            self.scrollView.contentOffset.x = self.bounds.width
            resetContentViewState()
            currentIndex = currentIndex + 1 < totalItems ? currentIndex + 1 : 0
            fillDataLayout()
        default:
            break
        }
        scrollView.isScrollEnabled = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if displayedView?.player.isPlay == true {
            displayedView?.player.isPlay = false
        }
        transformViewsInScrollView(scrollView)
    }
    
    private func transformViewsInScrollView(_ scrollView: UIScrollView) {
        let xOffset = scrollView.contentOffset.x
        let svWidth = self.frame.width
        var deg = maxAngle / svWidth * xOffset
        let childViews = contentStackView.arrangedSubviews
        for index in 0 ..< childViews.count {
            
            let view = childViews[index]
            
            deg = index == 0 ? deg : deg - maxAngle
            let rad = deg * CGFloat(Double.pi / 180)
            
            var transform = CATransform3DIdentity
            transform.m34 = 1 / 1000
            transform = CATransform3DRotate(transform, rad, 0, 1, 0)
            
            view.layer.transform = transform
            
            let x = xOffset / svWidth > CGFloat(index) ? 1.0 : 0.0
            setAnchorPoint(CGPoint(x: x, y: 0.5), forView: view)
            
//            applyShadowForView(view, index: index)
        }
    }
    
    private func applyShadowForView(_ view: UIView, index: Int) {
        
        let w = self.frame.size.width
        let h = self.frame.size.height
        
        let r1 = frameFor(origin: scrollView.contentOffset, size: self.frame.size)
        let r2 = frameFor(origin: CGPoint(x: CGFloat(index)*w, y: 0),
                          size: CGSize(width: w, height: h))
        
        // Only show shadow on right-hand side
        if r1.origin.x <= r2.origin.x {
            
            let intersection = r1.intersection(r2)
            let intArea = intersection.size.width*intersection.size.height
            let union = r1.union(r2)
            let unionArea = union.size.width*union.size.height
            
            view.layer.opacity = Float(intArea / unionArea)
        }
    }
    
    private func setAnchorPoint(_ anchorPoint: CGPoint, forView view: UIView) {
        var newPoint = CGPoint(x: view.bounds.size.width * anchorPoint.x, y: view.bounds.size.height * anchorPoint.y)
        var oldPoint = CGPoint(x: view.bounds.size.width * view.layer.anchorPoint.x, y: view.bounds.size.height * view.layer.anchorPoint.y)
        
        newPoint = newPoint.applying(view.transform)
        oldPoint = oldPoint.applying(view.transform)
        
        var position = view.layer.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        view.layer.position = position
        view.layer.anchorPoint = anchorPoint
    }
    
    private func frameFor(origin: CGPoint, size: CGSize) -> CGRect {
        return CGRect(x: origin.x, y: origin.y, width: size.width, height: size.height)
    }
}
