//
//  NavigationController+UIExtension.swift
//  StockFrame
//
//  Created by fdt on 2018/6/28.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

extension NavigationControllerBase {
    
    func gotoPageWithNodeItem(_ nodeItem: NodeItem, params: Dictionary<String,AnyObject>?) {
        
        let curPageId = (self.topViewController as! ViewControllerBase).pageId
        let curNodeItem = NodeManager.sharedInstance.getNodeItemWithId(curPageId)
        let curPageStackLevel = curNodeItem.stackLevel //当前页面的stacklevel
        let newPageStackLevel = nodeItem.stackLevel //新页面的stacklevel
        let newPageId = nodeItem.id
        var className = nodeItem.vcName
        //按照栈level操作
        if newPageId == curPageId { //当前页面
            //刷新当前页面
            FDTLog.logDebug("刷新当前页面")
            return
        } else if newPageStackLevel == curPageStackLevel { //栈level相等
            if className == "" {
                className = "ViewControllerBase"
            }
            let module = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
            let typeViewController = NSClassFromString(module + "." + className) as! ViewControllerBase.Type
            let newViewController = typeViewController.init()
            newViewController.navTitle = nodeItem.value
            newViewController.beloneStackId = naviId
            newViewController.pageId = newPageId
            var arr = Array.init(self.viewControllers)
            let start = arr.count - 1
            let end = arr.count
            arr.replaceSubrange(Range(start..<end), with: [newViewController] as Array<ViewControllerBase>)
            self.setViewControllers(arr, animated: false)
            return
            
        } else if newPageStackLevel > curPageStackLevel { //新栈level比当前栈level大
            if className == "" {
                className = "ViewControllerBase"
            }
            let module = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
            let typeViewController = NSClassFromString(module + "." + className) as! ViewControllerBase.Type
            let newViewController = typeViewController.init()
            newViewController.navTitle = nodeItem.value
            newViewController.beloneStackId = naviId
            newViewController.pageId = newPageId
            self.pushViewController(newViewController, animated: true)
            return
        } else if newPageStackLevel < curPageStackLevel { //新栈level比当前栈level大
            //当前栈数
            let curNavStackSize = self.viewControllers.count
            
            //当前栈数等于1
            //一般情况下走不到这里
            if curNavStackSize == 1 {
                if className != "" {
                    let module = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
                    let typeViewController = NSClassFromString(module + "." + className) as! ViewControllerBase.Type
                    let newViewController = typeViewController.init()
                    newViewController.navTitle = nodeItem.value
                    newViewController.beloneStackId = naviId
                    newViewController.pageId = newPageId
                    let arr = [newViewController]
                    self.setViewControllers(arr, animated: false)
                } else {
                    //刷新当前界面
                }
                return
            }
            
            // 如果当前栈数组中包含新建页面，说明页面已经创建过了，弹出栈level大于目标页面栈level的页面
            //如果当前栈数组中不存在新建的页面则弹出栈level大于目标页面栈level的页面 然后新建页面载入
            var start = 0
            let end = curNavStackSize
            for index in (0..<curNavStackSize).reversed() {
                let vc = self.viewControllers[index] as! ViewControllerBase
                let vcPageId = vc.pageId
                let vcPageStack = NodeManager.sharedInstance.getNodeItemWithId(vcPageId).stackLevel
                if vcPageStack > newPageStackLevel {
                    continue
                }
                if vcPageStack == newPageStackLevel {
                    //如果id相等即同一个页面
                    if vcPageId == curPageId {
                        self.popToViewController(vc, animated: false)
                        break
                    }
                    if className == "" {
                        className = "ViewControllerBase"
                    }
                    let module = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
                    let typeViewController = NSClassFromString(module + "." + className) as! ViewControllerBase.Type
                    let newViewController = typeViewController.init()
                    newViewController.navTitle = nodeItem.value
                    newViewController.beloneStackId = naviId
                    newViewController.pageId = newPageId
                    var arr = Array.init(self.viewControllers)
                    start = index
                    arr.replaceSubrange(Range(start..<end), with: [newViewController] as Array<ViewControllerBase>)
                    self.setViewControllers(arr, animated: true)
                    break
                }
                if vcPageStack < newPageStackLevel {
                    if className == "" {
                        className = "ViewControllerBase"
                    }
                    let module = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
                    let typeViewController = NSClassFromString(module + "." + className) as! ViewControllerBase.Type
                    let newViewController = typeViewController.init()
                    newViewController.navTitle = nodeItem.value
                    newViewController.beloneStackId = naviId
                    newViewController.pageId = newPageId
                    var arr = Array.init(self.viewControllers)
                    start = index + 1
                    arr.replaceSubrange(Range(start..<end), with: [newViewController] as Array<ViewControllerBase>)
                    self.setViewControllers(arr, animated: true)
                    break
                }
            }
            return
        }
        FDTLog.logDebug("nav 导航错误")
    }
}
