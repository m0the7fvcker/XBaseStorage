# XBaseStorage

[![CI Status](https://img.shields.io/travis/Poly.ma/XBaseStorage.svg?style=flat)](https://travis-ci.org/Poly.ma/XBaseStorage)
[![Version](https://img.shields.io/cocoapods/v/XBaseStorage.svg?style=flat)](https://cocoapods.org/pods/XBaseStorage)
[![License](https://img.shields.io/cocoapods/l/XBaseStorage.svg?style=flat)](https://cocoapods.org/pods/XBaseStorage)
[![Platform](https://img.shields.io/cocoapods/p/XBaseStorage.svg?style=flat)](https://cocoapods.org/pods/XBaseStorage)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

XBaseStorage is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'XBaseStorage'
```

## 说明

Cache:

- AbstractMemoryCacheManager:抽象内存缓存类、使用时要继承该类、重写过期方法

- GlobalMemoryCacheManager:单例、全局内存缓存类，可以直接使用

- ScavengerManager：清理工具类，可以添加具体清理Handler，统一处理

DataBase:

- DatabaseManager:数据库管理类，单例、包含curd操作

- DatabaseMigrator：数据库迁移工具类，单例、项目中只要有任何模型修改，都需要修改版本号，然后在迁移方法中具体操作，在Appdelegate中调用

- DatabaseModels：realm数据库模型demo

Keychain：

- KeychainManager：Keychain工具类

SandBox:

- SandBox：沙盒工具、创建文件夹、获取路径等


## Author

Poly.ma, poly.ma@corp.to8to.com

## License

XBaseStorage is available under the MIT license. See the LICENSE file for more info.
