//
//  StockViewController.swift
//  StockFrame
//
//  Created by fdt on 2018/6/27.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class StockViewController: ViewControllerBase {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let btn = UIButton.init(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        btn.backgroundColor = UIColor.red
        btn.setTitle("股票", for: .normal)
        btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        self.view.addSubview(btn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getRankInfo() -> ([(category:RankingCategory, sort:FDTSortType)]?) {
        //todo check up down
        return [(RankingCategory.Amt, FDTSortType.descending),
                    (RankingCategory.SH, FDTSortType.descending),
                    (RankingCategory.Down, FDTSortType.ascending)]
    }
    @objc func btnAction(_ sender: Any) {
        
        if let rankInfo = getRankInfo() {
            for info in rankInfo {
                DataCenter.sharedInstance.doGetQuoteAndRank("SH", categories: [info])
            }
        }
        
        FDT_UI_Public_Proxy.GotoVCWithId(PAGE_ID_STOCK_INFO)
        FDTLog.logDebug("点击按钮")
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
