//
//  LoginViewController.swift
//  StockFrame
//
//  Created by fdt on 2018/7/9.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class LoginViewController: ViewControllerBase {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let btn = UIButton.init(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        btn.backgroundColor = UIColor.red
        btn.setTitle("登录详细信息", for: .normal)
        btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        self.view.addSubview(btn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func btnAction(_ sender: Any) {
//        FDT_UI_Public_Proxy.GotoVCWithId(6202)
        FDT_UI_Public_Proxy.showTips(text: "ljt")
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
