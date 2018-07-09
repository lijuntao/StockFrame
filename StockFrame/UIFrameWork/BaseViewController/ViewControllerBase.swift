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
        self.view.backgroundColor = FDTWMColor.statusBarColor.color
        self.setNavigationBar()
        self.setNavTitle()
        self.configuraLeftNavigationItem()
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
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: FDTWMColor.statusBarColor.color]
    }

    func configuraLeftNavigationItem() {
        
        let backItem = BaseBarButtonItem(title: "", style: .plain, target: self, action: #selector(self.popAction))
        self.navigationController?.navigationBar.tintColor = FDTWMColor.statusBarColor.color
        self.navigationController?.navigationBar.backIndicatorImage = UIImage.image("navbar_back_arrow")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage.image("navbar_back_arrow")
        self.navigationItem.backBarButtonItem = backItem
        
//        if (self.navigationController?.viewControllers.count)! > 1 {
//            let btn = UIButton.init(type: UIButtonType.custom)
//            btn.setTitle("返回", for: UIControlState())
//            btn.titleLabel?.font = UIFont.systemFont(ofSize: 16);
//            btn.titleLabel?.textAlignment = NSTextAlignment.left
//            btn.setImage(UIImage.image("navbar_back_arrow"), for: UIControlState())
////            btn.frame = CGRect(x: 0, y: 0, width: 58, height: 44);
//            btn.sizeToFit()
//            btn.contentHorizontalAlignment = .left
//            btn.contentVerticalAlignment = .center
//            btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
//            //        btn.applyNavBarConstraints(size: CGSize(width: 58, height: 44))
//            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 0);
//            btn.addTarget(self, action: #selector(self.popAction), for: UIControlEvents.touchUpInside)
//            let leftItem = BaseBarButtonItem.init(customView: btn);
//            self.navigationItem.leftBarButtonItems = [leftItem];
//        }
    }
    
    @objc func popAction() {
        self.navigationController?.popViewController(animated: true)
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
