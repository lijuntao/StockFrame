//
//  UserDefaults+Frame.swift
//  StockFrame
//
//  Created by fdt on 2018/7/10.
//  Copyright © 2018年 ljt. All rights reserved.
//

import Foundation


extension UserDefaults {
    // 账户信息
    struct AccountInfo: UserDefaultsSettable {
        enum defaultKeys: String {
            case user
            case pwd
        }
    }
    
    // 登录信息
    struct LoginInfo: UserDefaultsSettable {
        enum defaultKeys: String {
            case token
            case userId
            case isLogin
        }
    }
}

protocol UserDefaultsSettable {
    associatedtype defaultKeys: RawRepresentable
}

extension UserDefaultsSettable where defaultKeys.RawValue==String {
    
    //String
    static func set(value: String?, forKey key: defaultKeys) {
        let aKey = key.rawValue
        UserDefaults.standard.set(value, forKey: aKey)
    }
    static func string(forKey key: defaultKeys) -> String? {
        let aKey = key.rawValue
        return UserDefaults.standard.string(forKey: aKey)
    }
    
    //Bool
    static func set(value: Bool?, forKey key: defaultKeys) {
        let aKey = key.rawValue
        UserDefaults.standard.set(value, forKey: aKey)
    }
    static func bool(forKey key: defaultKeys) -> Bool? {
        let aKey = key.rawValue
        return UserDefaults.standard.bool(forKey: aKey)
    }
    //Int
    static func set(value: Int?, forKey key: defaultKeys) {
        let aKey = key.rawValue
        UserDefaults.standard.set(value, forKey: aKey)
    }
    static func int(forKey key: defaultKeys) -> Int? {
        let aKey = key.rawValue
        return UserDefaults.standard.integer(forKey: aKey)
    }
    
    //Double
    static func set(value: Double?, forKey key: defaultKeys) {
        let aKey = key.rawValue
        UserDefaults.standard.set(value, forKey: aKey)
    }
    static func double(forKey key: defaultKeys) -> Any? {
        let aKey = key.rawValue
        return UserDefaults.standard.double(forKey: aKey)
    }
    
    // data
    static func set(value: Data?, forKey key: defaultKeys) {
        let aKey = key.rawValue
        UserDefaults.standard.set(value, forKey: aKey)
    }
    static func data(forKey key: defaultKeys) -> Data? {
        let aKey = key.rawValue
        return UserDefaults.standard.data(forKey: aKey)
    }
    
    // Any
    static func set(value: Any?, forKey key: defaultKeys) {
        let aKey = key.rawValue
        UserDefaults.standard.set(value, forKey: aKey)
    }
    static func any(forKey key: defaultKeys) -> Any? {
        let aKey = key.rawValue
        return UserDefaults.standard.object(forKey: aKey)
    }
}
