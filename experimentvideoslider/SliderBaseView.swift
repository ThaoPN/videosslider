//
//  SliderBaseView.swift
//  experimentvideoslider
//
//  Created by Est Rouge on 2/14/20.
//  Copyright © 2020 ThaoPN. All rights reserved.
//

import UIKit

protocol SliderBaseViewDelegate: class {
    func showOn(_ duration: Double)
    func mediaReachEnd()
}

class SliderBaseView: UIView {
    lazy var contentImage: UIImageView = {
        let imv = UIImageView()
        return imv
    }()
    
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
}

extension UIView {
    @available(iOS 9, *)
    func fillToSuperview() {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let superview = self.superview {
            let left = self.leftAnchor.constraint(equalTo: superview.leftAnchor)
            let right = self.rightAnchor.constraint(equalTo: superview.rightAnchor)
            let top = self.topAnchor.constraint(equalTo: superview.topAnchor)
            let bottom = self.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            NSLayoutConstraint.activate([left, right, top, bottom])
        }
    }
}
