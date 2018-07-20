//
//  ScavengerManager.swift
//  XBaseStrage
//
//  Created by Poly.ma on 2018/7/19.
//

import UIKit

protocol ScavengerProtocol {
    var scId: String { get }
    func clearCache()
    func cacheSize() -> uint
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
class ScavengerManager: NSObject {
    
    static let `shared` = ScavengerManager()
    private override init() {}
    
    var scavengers: [ScavengerProtocol] = []
    var currentScavengers: [String: String] = Dictionary(minimumCapacity: 1)
    
    func addScavenger(scavenger: ScavengerProtocol) {
        let sc = scavenger
        if  currentScavengers.contains(where: {
            return $0.key.compare(sc.scId) == .orderedSame
        }) {
            return
        }
        
        currentScavengers.updateValue(sc.scId, forKey: sc.scId)
        scavengers.append(scavenger)
    }
    
    func removeScavenger(scavenger: ScavengerProtocol) {
        let sc = scavenger
        let index = scavengers.index {
            return $0.scId.compare(sc.scId) == .orderedSame
        }
        
        scavengers.remove(at: index!)
    }
}

extension ScavengerManager: ScavengerProtocol {
    
    var scId: String {
        get { return "" }
    }
    
    func clearCache() {
        scavengers.forEach {
            $0.clearCache()
        }
        //TODO 清楚沙盒缓存
    }
    
    func cacheSize() -> uint {
        var totalSize: uint = 0
        for sc in scavengers {
            totalSize += sc.cacheSize()
        }
        //TODO 加上沙盒缓存
        return totalSize
    }
}
