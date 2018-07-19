//
//  DataCenter+PostNotification.swift
//  StockFrame
//
//  Created by fdt on 2018/7/19.
//  Copyright © 2018年 ljt. All rights reserved.
//

import Foundation

extension DataCenter {
    func postNotification(withType type: ObserverOption, object: Any? = nil) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: Notification.Name(rawValue: String(type.rawValue)), object: object)
        }
    }
    
    func postNotification(withType type: ObserverOption, object: Any? = nil, userInfo: [AnyHashable : Any]? = nil) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: Notification.Name(rawValue: String(type.rawValue)), object: object, userInfo: userInfo)
        }
    }
}
