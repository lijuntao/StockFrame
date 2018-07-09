//
//  FDTUITabFrame.swift
//  StockFrame
//
//  Created by fdt on 2018/5/25.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class FDTUITabFrame: NSObject {
    var mainTabBar:TabBarControllerBase!          //主要的导航条控件，各个 tab 标签各支持一个独立的页面栈
    var popNavVC: NavigationControllerBase!        //弹出的导航条控制器。支持一个页面栈
    var popIsShow: Bool!    // 弹出页面是否显示
    var popNaviLandscape:NavigationControllerBase!//弹出的导航条控制器_横屏幕。支持一个页面栈
    var popIsShowLandscape: Bool! // 弹出页面是否显示_横屏幕
    
    var pageManager: Dictionary<String,Any>! //管理页面的对象，管理页面的生命周期，包括页面缓存
    override init() {
        super.init()
        pageManager = Dictionary<String, Any>()
        popIsShow = false
        popIsShowLandscape = false
        self.createBaseUI()
    }
    //MARK: private
    func createBaseUI() {
        mainTabBar = TabBarControllerBase.init()
        var navArray = [NavigationControllerBase]()
        let nodes = NodeManager.sharedInstance.getTabbarMenu()
        for item in nodes {
            let node = NodeManager.sharedInstance.getNodeItemWithId(item.id)
            var className = node.vcName
            if className == "" {
                className = "ViewControllerBase"
            }
            let module = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
            let typeViewController = NSClassFromString(module + "." + className) as! ViewControllerBase.Type
            let rootViewController = typeViewController.init()
            rootViewController.navTitle = node.name
            
            let rootNavViewController = NavigationControllerBase.init(rootViewController: rootViewController)
            rootNavViewController.setNavId(node.id, linkId: node.linkid, pagelist: node.pagelist)
            
            let arrayImageName = item.pic.components(separatedBy: ";")
            let tabBarImage = UIImage.image(arrayImageName.first!)
            var tabBarItem = UITabBarItem.init(title: node.name, image: tabBarImage, tag: node.id)
            if arrayImageName.count >= 2 {
                let tabBarSelectedImage = UIImage.image(arrayImageName[1])
                tabBarItem = UITabBarItem.init(title: node.name, image: tabBarImage, selectedImage: tabBarSelectedImage)
            }
            rootNavViewController.tabBarItem = tabBarItem
            navArray.append(rootNavViewController)
        }
        assert(navArray.count != 0, "tabBar控制器没有导航条控制器")
        mainTabBar.viewControllers = navArray
        
        // 创建Navigation的UI结构——主要用户显示模态的页面-竖屏幕模式
        let popPortraitNodes = NodeManager.sharedInstance.getPopPortraitMenu()
        for node in popPortraitNodes {
            var className = node.vcName
            if className == "" {
                className = "ViewControllerBase"
            }
            
            let module = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
            let typeViewController = NSClassFromString(module + "." + className) as! ViewControllerBase.Type
            let rootViewController = typeViewController.init()
            rootViewController.navTitle = node.name
            
            popNavVC = NavigationControllerBase.init()
            popNavVC.setNavId(node.id, linkId: node.linkid, pagelist: node.pagelist)
            popNavVC.isPopup = true
        }
    }
    
    
    func getMainTabBar() -> TabBarControllerBase {
        return mainTabBar
    }
    
    func getPopNavControler() -> NavigationControllerBase {
        return popNavVC
    }
    func getCurNavigationController() -> NavigationControllerBase? {
        
        if ((mainTabBar.selectedViewController as? NavigationControllerBase) != nil) {
            return (mainTabBar.selectedViewController as! NavigationControllerBase)
        }
        return nil
    }
}
