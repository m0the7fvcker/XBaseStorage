//
//  KeychainManager.swift
//  XBaseStorage
//
//  Created by Poly.ma on 2018/7/20.
//

import UIKit
import KeychainAccess

public class KeychainManager {
    
    public static let `shared` = KeychainManager()
    
    public func save(object: String, forKey key: String, serviceName name: String = "globalService", accessGroup group: String = "") -> Bool {
        let keychain = Keychain(service: name, accessGroup: group)
        do {
            try keychain.set(object, key: key)
            return true
        } catch _ {
            return false
        }
    }
    
    public func save(data: Data, forKey key: String, serviceName name: String = "globalService", accessGroup group: String = "") -> Bool {
        let keychain = Keychain(service: name, accessGroup: group)
        do {
            try keychain.set(data, key: key)
            return true
        } catch _ {
            return false
        }
    }
    
    public func get(objectForKey key: String, serviceName name: String = "globalService", accessGroup group: String = "") -> String? {
        let keychain = Keychain(service: name, accessGroup: group)
        do {
            let obj = try keychain.get(key)
            return obj
        } catch _ {
            return nil
        }
    }
    
    public func get(dataForKey key: String, serviceName name: String = "globalService", accessGroup group: String = "") -> String? {
        let keychain = Keychain(service: name, accessGroup: group)
        do {
            let obj = try keychain.get(key)
            return obj
        } catch _ {
            return nil
        }
    }
}
