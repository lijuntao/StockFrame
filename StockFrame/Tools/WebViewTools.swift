//
//  WebViewTools.swift
//  StockFrame
//
//  Created by fdt on 2018/7/5.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit
import WebKit;
class WebViewTools: NSObject {
    //清除缓存
    class func removeWebCache() {
        
        if #available(iOS 9.0, *) {
            let dateFrom: Date = Date.init(timeIntervalSince1970: 0)
            let websiteDataTypes: Set<String> = WKWebsiteDataStore.allWebsiteDataTypes()
            WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes, modifiedSince: dateFrom) {
                print("清除完成")
            }
        } else {
            let libraryDir = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
            let webkitFolderInLib = "\(libraryDir)/WebKit";
            let webKitFolderInCaches = "\(libraryDir)/Caches/"
            /* iOS8.0 WebView Cache的存放路径 */
            try? FileManager.default.removeItem(atPath: webKitFolderInCaches)
            try? FileManager.default.removeItem(atPath: webkitFolderInLib)
            
            let cookiesFolderPath = "\(libraryDir)/Cookies";
            try? FileManager.default.removeItem(atPath: cookiesFolderPath)
            URLCache.shared.removeAllCachedResponses();
            
            //删除cookie
            let storage = HTTPCookieStorage.shared
            if let cookies = storage.cookies {
                for cookie in cookies {
                    storage.deleteCookie(cookie)
                }
            }
        }
    }
}
