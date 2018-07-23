//
//  ViewController.swift
//  XBaseStorage
//
//  Created by Poly.ma on 07/19/2018.
//  Copyright (c) 2018 Poly.ma. All rights reserved.
//

import UIKit
import XBaseStorage
import RealmSwift

class Dog: Object {
    @objc dynamic var name: String?
    @objc dynamic var age = 0
    @objc dynamic var id: Int8 = 0
    
    let owner = LinkingObjects(fromType: Person.self, property: "dogs")
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}

class Person: Object {
    @objc dynamic var name: String?
    @objc dynamic var birthdate = NSDate()
    var dogs = List<Dog>()
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        testKeychain()
        testSanbox()
        testRealm()
    }
    
    func testSanbox() {
        print(NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true))
        print(SandBoxUtil.shared.getPath(withType: .library))
        print(SandBoxUtil.shared.caculateBytesAtPath(path: SandBoxUtil.shared.getPath(withType: .library)))
    }

    func testKeychain() {
        _ = KeychainManager.shared.save(object: "mark", forKey: "name", serviceName: "s1")
        _ = KeychainManager.shared.save(object: "mark2", forKey: "name", serviceName: "s2")
        
        print(KeychainManager.shared.get(objectForKey: "name", serviceName: "s1")!)
        print(KeychainManager.shared.get(objectForKey: "name", serviceName: "s2")!)

    }
    
    func testRealm() {
        
        
        let realm = try! Realm()
        print(realm.configuration.fileURL!)
        
        var dog = Dog()
        dog.id = 3
        dog.name = "阿三"
        dog.age = 3
        
        var dog1 = Dog()
        dog1.name = "阿四"
        dog1.age = 4
        dog1.id = 4
        
        var dog2 = Dog()
        dog2.name = "阿五"
        dog2.age = 5
        dog2.id = 5
        
//        try! realm.write {
//            realm.add(dog)
//            realm.add([dog1, dog2])
//        }
        
//        var dog2 = Dog(value: "name": "阿五", "age": 3)
//        var person = Person(value:"jack", [dog, dog1])
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

