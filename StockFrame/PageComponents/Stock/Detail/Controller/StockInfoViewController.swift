//
//  StockInfoViewController.swift
//  StockFrame
//
//  Created by fdt on 2018/6/28.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class StockInfoViewController: ViewControllerBase {

    var chartLineView = ChartLineView(frame: CGRect.zero)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        chartLineView.activeViewModel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        chartLineView.deactiveViewModel()
    }
    
    func initView() {
        let symbol = pageData![SYMBOLID_KEY] as! String
        chartLineView = ChartLineView(symbolId: symbol, period: .DC)
        let _ = self.view + chartLineView
    }
    
    override func updateViewConstraints() {
        
        chartLineView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(400)
        }
        
        super.updateViewConstraints()
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
