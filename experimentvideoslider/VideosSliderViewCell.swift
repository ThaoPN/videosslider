//
//  VideosSliderViewCell.swift
//  AkiTravel
//
//  Created by Est Rouge on 1/8/20.
//  Copyright © 2020 Aki Travel. All rights reserved.
//

import UIKit

class VideosSliderViewCell: UIView {
    var medias = [Media]()
    

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
