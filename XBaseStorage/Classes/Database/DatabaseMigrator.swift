//
//  DatabaseMigrator.swift
//  XBaseStorage
//
//  Created by Poly.ma on 2018/7/23.
//

import RealmSwift

public class DatabaseMigrator: NSObject {
    
    public class func startMigrateIfNeeded() {
        
        /// 当前数据库版本，当数据表有变动时一定要记得修改版本号
        let currentDBVersion: UInt64 = 9
        
        /// 配置数据库，在此方法中针对不同老版本进行数据迁移
        /// 数据库会自动为当前项目中的模型添加或移除字段，
        /// 对于不同的版本在对应的case中进行相关的数据迁移操作
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: currentDBVersion, migrationBlock: { (migration, oldVersion) in
            if(oldVersion >= currentDBVersion) { return }
            switch oldVersion {
            case 1:
                migration.enumerateObjects(ofType: "name", { (oldObj, newObj) in
                    newObj!["age"] = 1
                })
            case 2:
                migration.enumerateObjects(ofType: "", { (oldObj, newObj) in
                    newObj!["age"] = 1
                })
            // ...
            default: break
                
            }
            print("数据库迁移中...")
        })
        
        Realm.asyncOpen { (realm, error) in
            if let _ = realm {
                print("Realm 数据库配置成功")
            } else if let error = error {
                print("Realm 数据库配置失败：\(error.localizedDescription)")
            }
        }

        let realm = try! Realm()
        print(realm.configuration.fileURL!)
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
/*
 此处用于记录每个版本更改的信息，比如字段添加于修改等等信息，便于数据库迁移
 
 V1:...
 V2:...
 
**/
/////////////////////////////////////////////////////////////////////////////////////////////////////
