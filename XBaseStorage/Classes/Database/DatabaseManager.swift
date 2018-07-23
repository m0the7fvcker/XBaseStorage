//
//  DBManager.swift
//  XBaseStorage
//
//  Created by Poly.ma on 2018/7/23.
//

import RealmSwift

public class DBManager {

    public static let `default` = DBManager()
    
    let realm = try! Realm()
    
    /// 根据模型类查询所有元素
    ///
    /// - Parameter type: ModelType
    /// - Returns: Results
    public func selectObjects<Element: Object>(_ type: Element.Type) -> Results<Element> {
        return realm.objects(type)
    }
    
    /// 根据主键查询元素
    ///
    /// - Parameters:
    ///   - type: ModelType
    ///   - key: PrimaryKey
    /// - Returns: Element
    public func selectObject<Element: Object, KeyType>(ofType type: Element.Type, forPromaryKey key: KeyType) -> Element? {
        return realm.object(ofType: type, forPrimaryKey: key)
    }
    
    /// 开启事务，在事物中进行 增删改查，具体用法参考下面注释
    ///
    /// - Parameter transaction: transaction
    /// - Throws: Exception
    public func beginOperation(withTransaction transaction:(_ hander: Realm) -> ()) {
        transaction(realm)
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////
    // Delete
    // let dog = ... 存储在 Realm 中的 Dog 对象
    // let dogs = ... 存储在 Realm 中的多个 Dog 对象
    /* 在事务中删除数据 */
    // try! handler.write {
    //      handler.delete(dog) // 删除单个数据
    //      handler.delete(dogs) // 删除多个数据
    //      handler.deleteAll() // 从 Realm 中删除所有数据
    //}
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////
    // Update
    // let dog = ... 存储在 Realm 中的 Dog 对象
    /* 在一个事务中修改数据 */
    // DBManager.default.beginOperation { (handler) in
    //    try! handler.write {
    //       dog.name = "张三"
    //    }
    // }
    // let dogs = ... 存储在 Realm 中的多个 Dog 对象
    /* 在一个事务中修改数据 */
    // DBManager.default.beginOperation { (handler) in
    //    try? handler.write {
    //       dogs.first?.setValue("张三", forKeyPath: "name") // 将第一个狗狗名字改为张三
    //       dogs.setValue("张三", forKeyPath: "name") // 将所有狗狗名字都改为张三
    //    }
    // }

    // let dog = ... 存储在 Realm 中的 Dog 对象（有主键）
    // let dogs = ... 存储在 Realm 中的多个 Dog 对象（有主键）
    /* 在一个事务中修改数据，通过主键，若主键不存在则自动添加 */
    // DBManager.default.beginOperation { (handler) in
    //    try? handler.write {
    //        handler.add(dog, update: true) // 更新单个数据
    //        handler.add(dogs, update: true) // 更新多个数据
    //    }
    // }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////
    // Insert
    /* 创建一个 Dog 对象 */
    // let dog = Dog(value: ["name" : "豆豆", "age": 3])
    /* 创建一个 Dog 对象数组 */
    // let dogs = [Dog(value: ["name": "张三", "age": 1]), Dog(value: ["name": "李四", "age": 2]), Dog(value: ["name": "王五", "age": 3])]
    /* 通过事务将数据添加到 Realm 中 */
    // DBManager.default.beginOperation { (handler) in
    //    try? handler.write {
    //        handler.add(dog) // 增加单个数据
    //        handlerm.add(dogs) // 增加多个数据
    //        handler.create(Dog.self, value: ["name" : "豆豆", "age": 3], update: true) // 直接根据 JSON 数据增加
    //    }
    // }
    
    //...
}

