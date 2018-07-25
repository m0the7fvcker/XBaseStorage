//
//  GlobalMemoryCacheManager.swift
//  XBaseStrage
//
//  Created by Poly.ma on 2018/7/19.
//

import Foundation

public class GlobalMemoryCacheManager: AbstractMemoryCacheManager {
    
    public static let `shared` = GlobalMemoryCacheManager()
    
    override public func expireTime() -> TimeInterval {
        return 60 * 60 * 24
    }
}



