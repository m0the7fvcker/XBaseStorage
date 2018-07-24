//
//  DataBaseModels.swift
//  XBaseStorage
//
//  Created by Poly.ma on 2018/7/23.
//

/// 此文件中专门放需要传入数据库中的模型，只要是继承自Object的类
/// 都会在.realm数据库中生成对应的数据表，由于reaml的底层非
/// coreData和sqllite，所以要按照realm的规范来使用realm
/// 简单使用可以参考https://www.jianshu.com/p/06782df0b901
/// 具体使用可以查看https://realm.io/cn/docs/swift/latest/#threading

import RealmSwift

protocol DBModelProtocol {}

class ExampleModel: Object {
    @objc dynamic var identifier: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var age: NSDate = NSDate()
    @objc dynamic var sex: String?
    @objc dynamic var home: String?
}

