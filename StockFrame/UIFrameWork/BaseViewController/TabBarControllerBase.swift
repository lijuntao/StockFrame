//
//  TabBarControllerEx.swift
//  StockFrame
//
//  Created by fdt on 2018/5/25.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class TabBarControllerBase: UITabBarController {

    var nodeId: Int = 0
    var curSelectIndex: Int = 0
    var memoryWarning: Int = 0
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        nodeId = 0
        curSelectIndex = 0
        memoryWarning = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initSubview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initSubview() {
        var tabBarHeight = 49
        if FDTTools.isIphoneX() {
            tabBarHeight = 83
        }
        let backView = UIView(frame: CGRect(x: 0,y: 0,width: Int(self.view.frame.width),height: tabBarHeight));
        backView.backgroundColor = FDTWMColor.navigationColor.color
        self.tabBar.insertSubview(backView, at: 0);
        tabBar.isOpaque = true;
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
