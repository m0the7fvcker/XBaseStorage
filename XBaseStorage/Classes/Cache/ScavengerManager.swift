//
//  ScavengerManager.swift
//  XBaseStrage
//
//  Created by Poly.ma on 2018/7/19.
//

import UIKit

public protocol ScavengerProtocol {
    var scId: String { get }
    func clearCache()
    func cacheSize() -> UInt64
}

public enum CacheType: String {
    case root = "app_cache_root"
    case searchHistory = "search_history"
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
public class ScavengerManager {
    
    public static let `shared` = ScavengerManager()
    
    public var scavengers: [ScavengerProtocol] = []
    public var currentScavengers: [String: String] = Dictionary(minimumCapacity: 1)
    
    public func addScavenger(scavenger: ScavengerProtocol) {
        let sc = scavenger
        if  currentScavengers.contains(where: {
            return $0.key.compare(sc.scId) == .orderedSame
        }) {
            return
        }
        
        currentScavengers.updateValue(sc.scId, forKey: sc.scId)
        scavengers.append(scavenger)
    }
    
    public func removeScavenger(scavenger: ScavengerProtocol) {
        let sc = scavenger
        let index = scavengers.index {
            return $0.scId.compare(sc.scId) == .orderedSame
        }
        
        scavengers.remove(at: index!)
    }
    
    public func getRootCachePath(withType type: CacheType) -> String {
        let cachePath = SandBoxUtil.shared.getPath(withType: .cache)
        let subCachePath = "\(cachePath)/\(type.rawValue)"
        if !FileManager.default.fileExists(atPath: subCachePath) {
            try? SandBoxUtil.shared.createFolder(folderName: subCachePath, atDir: .cache)
        }
        return subCachePath
    }
}

extension ScavengerManager: ScavengerProtocol {
    
    public var scId: String {
        get { return "" }
    }
    
    public func clearCache() {
        scavengers.forEach {
            $0.clearCache()
        }
        // 清除沙盒缓存根目录缓存
        let fileMgr = FileManager.default
        let rootCachePath = getRootCachePath(withType: .root)
        if fileMgr.fileExists(atPath: rootCachePath) {
            try? fileMgr.removeItem(atPath: rootCachePath)
        }
    }
    
    public func cacheSize() -> UInt64 {
        var totalSize: UInt64 = 0
        for sc in scavengers {
            totalSize += sc.cacheSize()
        }
        // 加上沙盒缓存根目录大小
        totalSize += SandBoxUtil.shared.caculateBytesAtPath(path: getRootCachePath(withType: .root))
        return totalSize
    }
}
