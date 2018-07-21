//
//  ViewControllerBase.swift
//  StockFrame
//
//  Created by fdt on 2018/6/15.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class ViewControllerBase: UIViewController {

    var navTitle: String?
    
    var pageData: Dictionary<String,AnyObject>? //跳转页面时携带的参数
    
    var beloneStackId = 0 //属于的栈 id
    var pageId = 0 ////当前显示的页面id
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = FDTWMColor.backgroundColor.color
        self.setNavigationBar()
        self.setNavTitle()
        self.configuraLeftNavigationItem()
        self.configuraRightNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        FDTLog.logDebug("\(pageId) 释放")
    }
    
    func setNavTitle() {
        if let title = navTitle {
            self.navigationItem.title = title
        } else {
            self.navigationItem.title = "--"
        }
    }
    
    func setNavigationBar() {
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = FDTWMColor.navigationColor.color
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: FDTWMColor.whiteColor.color]
    }

    func configuraLeftNavigationItem() {
        
        guard let navigationVC = self.navigationController as? NavigationControllerBase else {
            return
        }
        
        if navigationVC.isPopup && navigationVC.viewControllers.count == 1 {
            let btn = UIButton.init(type: UIButtonType.custom)
            btn.setTitle("关闭", for: UIControlState())
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 17);
            btn.titleLabel?.textAlignment = NSTextAlignment.left
            btn.sizeToFit()
            btn.contentHorizontalAlignment = .left
            btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
            btn.addTarget(self, action: #selector(self.disAction), for: UIControlEvents.touchUpInside)
            let leftItem = BaseBarButtonItem.init(customView: btn);
            self.navigationItem.leftBarButtonItems = [leftItem];
        } else {
//            let backItem = BaseBarButtonItem(title: "", style: .plain, target: self, action: #selector(self.popAction))
//            navigationVC.navigationBar.tintColor = FDTWMColor.statusBarColor.color
//            navigationVC.navigationBar.backIndicatorImage = UIImage.image("navbar_back_arrow")
//            navigationVC.navigationBar.backIndicatorTransitionMaskImage = UIImage.image("navbar_back_arrow")
//            self.navigationItem.backBarButtonItem = backItem
            
            if navigationVC.viewControllers.count > 1 {
                let btn = UIButton.init(type: UIButtonType.custom)
                btn.setTitle("返回 ", for: UIControlState())
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 16);
                btn.titleLabel?.textAlignment = NSTextAlignment.left
                btn.setImage(UIImage.Asset.Nav_backArrow.image, for: UIControlState())
                btn.sizeToFit()
                btn.contentHorizontalAlignment = .left
                btn.contentVerticalAlignment = .center
                btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
                btn.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 0);
                btn.addTarget(self, action: #selector(self.popAction), for: UIControlEvents.touchUpInside)
                let leftItem = BaseBarButtonItem.init(customView: btn);
                self.navigationItem.leftBarButtonItems = [leftItem];
            }
        }
    }
    
    func configuraRightNavigationItem() {
        //
    }
    
    @objc func popAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func disAction() {
        self.navigationController?.dismiss(animated: true, completion: nil)
//        FDT_UI_Public_Proxy.getPopNavigationVC().dismiss(animated: true, completion: nil)
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
