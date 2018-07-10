//
//  NavigationControllerEx.swift
//  StockFrame
//
//  Created by fdt on 2018/5/25.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class NavigationControllerBase: UINavigationController {

    var naviId: Int = 0         //导航控制器id，用来区别不同的导航控制器
    var basePageId: Int = 0     //导航控制器对应的基页面的页面id
    var isPopup: Bool = false   //是否是弹出显示的
    var bMoving: Bool = false   //是否处于滑动返回手势的滑动状态
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        naviId = 0
        basePageId = 0
        isPopup = false
        bMoving = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isPopup = false
    }

    //设置导航条控制器id，根页面的页面id，导航条控制器对应的栈的页面集合id
    func setNavId(_ id: Int, linkId: Int, pagelist: Int) {
        naviId = pagelist
        basePageId = linkId
        
        let array = self.viewControllers
        if array.count > 0 {
            let baseViewController = array.first as! ViewControllerBase
            baseViewController.beloneStackId = id
            baseViewController.pageId = linkId
        }
    }
    //替换root VC
    func replaceRootViewController(node: NodeItem) {
        var className = node.vcName
        if className == "" {
            className = "ViewControllerBase"
        }
        
        let module = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        let typeViewController = NSClassFromString(module + "." + className) as! ViewControllerBase.Type
        let rootViewController = typeViewController.init()
        rootViewController.navTitle = node.name
        rootViewController.beloneStackId = naviId
        rootViewController.pageId = node.id
        var arr = Array.init(self.viewControllers)
        let start = 0
        let end = arr.count
        arr.replaceSubrange(Range(start..<end), with: [rootViewController] as Array<ViewControllerBase>)
        self.setViewControllers(arr, animated: false)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
