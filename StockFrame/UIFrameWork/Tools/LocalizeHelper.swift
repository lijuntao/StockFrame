//
//  LocalizeHelper.swift
//  FDTWMWebApp
//
//  Created by fdt on 2018/6/1.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class LocalizeHelper: NSObject {
    // Singleton
    static let sharedInstance = LocalizeHelper()
    
    var myBundle:Bundle!
    
    var bundleLanguage:String!
    
    override init() {
        super.init()
        let la = self.deviceLanguage()
        let url = Bundle.main.url(forResource: la, withExtension: "lproj")!
        //let bundlePath = Bundle.main.ur；(forResource: self.deviceLanguage(), ofType: "lproj")//Bundle.main.path(forResource: self.deviceLanguage)
        myBundle = Bundle(url: url)
    }
    
    func localizedStringForKey(_ key: String) -> String {
        let string = myBundle?.localizedString(forKey: key, value: key, table: nil)
        
        if string != key {
            return string!
        } else {
            return "--"
        }
    }
    
    func localizedStringForKey(_ key: L10n) -> String {
        return (myBundle?.localizedString(forKey: tr(key), value: tr(key), table: nil))!
    }
    
    func deviceLanguage() -> String {
        
        let language = FDTOCTools.getDeviceLanguage()
        
        switch language {
        case .CN:
            return "zh-Hans"
        case .TW:
            return "zh-Hant"
        default:
            return "zh-Hans"
        }
    }
}
