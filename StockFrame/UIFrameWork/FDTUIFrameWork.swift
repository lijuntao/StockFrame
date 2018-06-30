//
//  FDTUIFrameWork.swift
//  StockFrame
//
//  Created by fdt on 2018/5/25.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class FDTUIFrameWork: NSObject {
    static let sharedInstance = FDTUIFrameWork.init()
    
    var g_UITabFrame:FDTUITabFrame!
    var publicValues:Dictionary<String,AnyObject>! //公共数据存储
    
    override init() {
        publicValues = Dictionary<String, AnyObject>()
    }
    
    deinit {
        publicValues = nil
    }
    
    private func createFrameWorkWithType() -> FDTUITabFrame {
        let uiFrameWork = FDTUITabFrame()
        return uiFrameWork
    }
    
    func shareingUIFramework() -> FDTUITabFrame {
        if g_UITabFrame == nil {
            g_UITabFrame = createFrameWorkWithType()
        }
        return g_UITabFrame!
    }
    
    // UI跳转
    func goToVCWithId(_ id: Int, params: Dictionary<String,AnyObject>?, needPop: Bool = false) {
        //根据id获取节点详细信息
        let nodeItem = NodeManager.sharedInstance.getNodeItemWithId(id)
        
        self.gotoRealVCWithNodeItem(nodeItem, params: params, needPop: needPop)
    }
    
    func gotoRealVCWithNodeItem(_ nodeItem: NodeItem, params: Dictionary<String,AnyObject>?, needPop: Bool = false) {
        FDTLog.logDebug("跳转：\(nodeItem.id)-\(nodeItem.vcName)")
        
        //获取tabbar视图
        let mainTabbar = self.shareingUIFramework().getMainTabBar()
        
        //既不是横屏弹出页面也不是竖屏弹出页面，则是竖屏普通页面
        let curSelected = mainTabbar.selectedIndex
        //获得当前显示的 page 显示的位置（比如tabBar下面某个导航栈）
        let navigationIndex = NodeManager.sharedInstance.getTabBarItemIndex(nodeItem.id, curSelected: curSelected)
        if navigationIndex != curSelected &&
            navigationIndex >= 0 &&
            navigationIndex < (mainTabbar.viewControllers?.count)!{
            let navigationVC = mainTabbar.viewControllers![navigationIndex] as! NavigationControllerBase
            navigationVC.gotoPageWithNodeItem(nodeItem, params: params)
            mainTabbar.curSelectIndex = navigationIndex
            mainTabbar.selectedIndex = navigationIndex
            return
        }
        
        if let curNavigationVC = self.getCurNavigationController() {
            curNavigationVC.gotoPageWithNodeItem(nodeItem, params: params)
            return
        }
        FDTLog.logDebug("跳转失败")
    }
    
    func getCurNavigationController() -> NavigationControllerBase? {
        return self.shareingUIFramework().getCurNavigationController()
    }
    // MARK: 全局字典
    func setPublicValue(forKey key: String, value:AnyObject) {
        publicValues.updateValue(value, forKey: key)
    }
    
    func getPublicValue(forKey: String) -> AnyObject? {
        return publicValues[forKey]
    }
    
    func removePublicValue(forKey: String) {
        publicValues.removeValue(forKey: forKey)
    }
    
}
