//
//  SandBoxUtil.swift
//  XBaseStrage
//
//  Created by Poly.ma on 2018/7/19.
//

import Foundation

public enum SandboxDirType {
    case document
    case library
    case cache
    case tmp
}

public enum SandboxCreateFileError: Error {
    case dirExist
    case fileExist
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
public class SandBoxUtil: NSObject {
    
    let _identifier_prfix = "_identifier_prfix_"
    
    public static let `shared` = SandBoxUtil()
    private override init() {}
    
    func documentPath() -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
    }
    
    func libraryPath() -> String {
        return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).last!
    }
    
    func cachePath() -> String {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last!
    }
    
    func tmpPath() -> String {
        return NSTemporaryDirectory()
    }
    
    public func getPath(withType type: SandboxDirType) -> String {
        switch type {
        case .document:
            return documentPath()
        case .library:
            return libraryPath()
        case .cache:
            return cachePath()
        case .tmp:
            return tmpPath()
        }
    }
    
    public func createFolder(folderName: String, atDir dir: SandboxDirType) throws {
        let mgr = FileManager.default
        var path = getPath(withType: dir)
        path.append("/\(folderName)")
        
        var isDir: ObjCBool = ObjCBool(false)
        if mgr.fileExists(atPath: path, isDirectory: &isDir) {
            if isDir.boolValue {
                throw SandboxCreateFileError.dirExist
            } else {
                throw SandboxCreateFileError.fileExist
            }
        }
        
        do {
            try mgr.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        } catch let error {
            throw error
        }
    }
    
    public func saveDataToUserDefualt(object: Any?, forKey key: String) {
        UserDefaults.standard.set(object, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    public func getDataFromUserDefault(forKey key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    public func removeDataFromUserDefault(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    public func saveDataToUserDefualt(object: Any?, forKey key: String, forIdentifier id: String) {
        let identifier = "\(_identifier_prfix)\(id)"
        
        var dataDic = UserDefaults.standard.object(forKey: identifier) as? Dictionary<String, Any>
        if dataDic != nil {
            dataDic![key] = object
        } else {
            var dataDic = Dictionary<String, Any>()
            dataDic[key] = object
        }
        UserDefaults.standard.set(dataDic, forKey: identifier)
        UserDefaults.standard.synchronize()
    }
    
    public func getDataFromUserDefault(forKey key: String, forIdentifier id: String) -> Any? {
        let dataDic = UserDefaults.standard.object(forKey: id) as? Dictionary<String, Any>
        if dataDic != nil {
            return dataDic![key]
        } else {
            return nil
        }
    }
    
    public func removeDataFromUserDefault(forKey key: String, forIdentifier id: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    /// 计算指定路径文件大小
    ///
    /// - Parameter path: path
    /// - Returns: filesize
    public func caculateBytesAtPath(path: String) -> UInt64 {
        
        let mgr = FileManager.default
        var isDir: ObjCBool = ObjCBool(false)
        
        if !mgr.fileExists(atPath: path, isDirectory: &isDir) {
            return 0
        }
        
        if !isDir.boolValue {
            if let files = try? mgr.attributesOfItem(atPath: path) {
                return files[FileAttributeKey("NSFileSize")] as! UInt64
            }
        }

        let subPaths = mgr.subpaths(atPath: path)
        
        var totalSize: UInt64 = 0
        subPaths?.forEach({ (subPath) in
            let newSubPath = "\(path)/\(subPath)"
            if mgr.fileExists(atPath: newSubPath, isDirectory: &isDir) {
                if !isDir.boolValue {
                    if let files = try? mgr.attributesOfItem(atPath: path) {
                        totalSize += files[FileAttributeKey("NSFileSize")] as! UInt64
                    }
                }
            }
        })
        return totalSize
    }
}
