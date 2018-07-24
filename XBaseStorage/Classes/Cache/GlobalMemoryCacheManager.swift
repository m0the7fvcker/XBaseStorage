//
//  GlobalMemoryCacheManager.swift
//  XBaseStrage
//
//  Created by Poly.ma on 2018/7/19.
//

import Foundation

class GlobalMemoryCacheManager: AbstractMemoryCacheManager {
    
    override func expireTime() -> TimeInterval {
        return 60 * 60 * 24
    }
}


