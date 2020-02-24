//
//  MediaObject.swift
//  experimentvideoslider
//
//  Created by Est Rouge on 2/24/20.
//  Copyright © 2020 ThaoPN. All rights reserved.
//

import UIKit

enum MediaType {
    case image, video
}

class MediaObject: NSObject {
    var url: URL
    var type: MediaType
    var thumbnailUrl: URL?
    
    init(_ url: URL, type: MediaType, thumbnailUrl: URL? = nil) {
        self.url = url
        self.type = type
        self.thumbnailUrl = thumbnailUrl
        super.init()
    }
}
