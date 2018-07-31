//
//  AbstractMemoryCacheManager.swift
//  XBaseStrage
//
//  Created by Poly.ma on 2018/7/19.
//

import Foundation

public protocol MemoryCacheProtocol {
    
    /// 设置过期时间
    ///
    /// - Returns: timeInterval
    func expireTime() -> TimeInterval
    
    /// 设置缓存
    ///
    /// - Parameters:
    ///   - object: object
    ///   - key: key
    /// - Returns: void
    func cache(object: Any, forKey key: String)
    
    /// 移除缓存
    ///
    /// - Parameters:
    ///   - object: object
    ///   - key: key
    /// - Returns: void
    func remove(object: Any, forKey key: String)

    /// 重置
    ///
    /// - Returns: void
    func resetExpireTime()
    
    /// 清除所有缓存
    ///
    /// - Returns: void
    func clearCache()
    
    /// 获取缓存
    ///
    /// - Parameter key: key
    /// - Returns: void
    func cache(forKey key: String) -> Any?
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
open class AbstractMemoryCacheManager {
    
    var refreshDate: Date = Date()
    var cacaheDic: [String: Any] = Dictionary(minimumCapacity: 1)
    
    open func expireTime() -> TimeInterval {
        assert(false, "抽象方法，需要子类实现")
        return 0
    }
    
    public init() {}
}

extension AbstractMemoryCacheManager: MemoryCacheProtocol {
    
    
    open func cache(value: Any, forKey key: String) {
        cacaheDic.updateValue(value, forKey: key)
    }

    open func removeValue(forKey key: String) {
        cacaheDic.removeValue(forKey: key)
    }
    
    open func resetExpireTime() {
        refreshDate = Date()
    }

    open func clearCache() {
        cacaheDic.removeAll()
    }
    
    open func cache(forKey key: String) -> Any? {
        if self.checkWhetherExpired() {
            return nil
        }
        return cacaheDic[key] ?? nil
    }
    
    open func checkWhetherExpired() -> Bool {
        return Date().compare((refreshDate.addingTimeInterval(self.expireTime()))) == .orderedDescending
    }
}
