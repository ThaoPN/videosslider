//
//  VideosSliderView.swift
//  AkiTravel
//
//  Created by Est Rouge on 1/8/20.
//  Copyright © 2020 Aki Travel. All rights reserved.
//

import UIKit

class VideosSliderView: UIView {
    lazy var scrollView: UIScrollView = {
        let scrView = UIScrollView()
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
        print(scrollView.contentOffset.x)
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
        for _ in 0..<3 {
            let view = VideosSliderViewCell(frame: bounds)
            view.clipsToBounds = true
            view.backgroundColor = .random()
            contentStackView.addArrangedSubview(view)
        }
        
        contentStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: CGFloat(contentStackView.arrangedSubviews.count)).isActive = true
    }
}
