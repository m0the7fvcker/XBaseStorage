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
    @objc dynamic var id: Int8 = 0
    @objc dynamic var name: String?
    @objc dynamic var birthdate = Date()
    var dogs = List<Dog>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton()
        
        testKeychain()
        testSanbox()
    }
    
    func addButton() {
        let btn = UIButton(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(addData), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    @objc func addData() {
        let dog = Dog()
        dog.id = 3
        dog.name = "阿三"
        dog.age = 3
        
        let dog1 = Dog()
        dog1.name = "阿四"
        dog1.age = 4
        dog1.id = 4
        
        let dog2 = Dog()
        dog2.name = "阿五"
        dog2.age = 5
        dog2.id = 5
        
        let p1 = Person(value: [1, "jack", Date(), [dog, dog1, dog2]])
        
        DatabaseManager.default.beginOperation { (hander) in
            do {
                try hander.write {
                    hander.add([dog, dog1, dog2], update: true)
                    hander.add(p1, update: true)
                }
                print("数据更新成功")
            } catch _ {
                print("数据更新失败")
            }
            
        }
    }
    
    func testSanbox() {
        print(NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true))
        print(SandBoxUtil.shared.getPath(withType: .library))
        print(SandBoxUtil.shared.caculateBytesAtPath(path: SandBoxUtil.shared.getPath(withType: .library)))
        try? SandBoxUtil.shared.createFolder(folderName: "default.realm", atDir: .document)
    }

    func testKeychain() {
        _ = KeychainManager.shared.save(object: "mark", forKey: "name", serviceName: "s1")
        _ = KeychainManager.shared.save(object: "mark2", forKey: "name", serviceName: "s2")
        
        print(KeychainManager.shared.get(objectForKey: "name", serviceName: "s1")!)
        print(KeychainManager.shared.get(objectForKey: "name", serviceName: "s2")!)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

class Test {
    var mg = GlobalMemoryCacheManager.shared
    
    func test() {
        mg.resetExpireTime()
    }
}

