//
//  FinancialViewController.swift
//  StockFrame
//
//  Created by fdt on 2018/6/27.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class FinancialViewController: ViewControllerBase {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let btn = UIButton.init(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        btn.backgroundColor = UIColor.red
        btn.setTitle("理财", for: .normal)
        btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        self.view.addSubview(btn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        DataCenter.sharedInstance.doQuoteRef(["BABA.US.WM"])
//        DataCenter.sharedInstance.doQuoteRef(["000002.SZ.WM"])
//        DataCenter.sharedInstance.doQuoteRef(["HSI.HK.WM"])
        DataCenter.sharedInstance.doTickRef(["BABA.US.WM"], period: .DC)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        DataCenter.sharedInstance.doQuoteUnRef(["BABA.US.WM"])
//        DataCenter.sharedInstance.doQuoteUnRef(["000002.SZ.WM"])
//        DataCenter.sharedInstance.doQuoteRef(["HSI.HK.WM"])
    }
    @objc func btnAction(_ sender: Any) {
        FDT_UI_Public_Proxy.GotoVCWithId(PAGE_ID_MINE)
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
