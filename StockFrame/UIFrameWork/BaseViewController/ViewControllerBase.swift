//
//  ViewControllerBase.swift
//  StockFrame
//
//  Created by fdt on 2018/6/15.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class ViewControllerBase: UIViewController {

    var beloneStackId = 0 //属于的栈 id
    var focusPageId = 0 ////当前显示的页面id
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
