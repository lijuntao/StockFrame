//
//  StockRankMoreViewController.swift
//  StockFrame
//
//  Created by fdt on 2018/7/22.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class StockRankMoreViewController: ViewControllerBase {

    var stockRankMoreView: StockRankMoreView!
    var refreshControl = FDTRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initView()
        self.initRefreshControl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.activeView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.deactiveView()
    }
    
    func activeView() {
        stockRankMoreView.activeViewModel()
    }
    
    func deactiveView() {
        stockRankMoreView.deactiveViewModel()
    }
    
    // MARK: Privite
    func initView() {
        let category = pageData![CATEGORY_KEY] as! RankingCategory
        let marketType = pageData![MARKET_KEY] as! MarketType
        stockRankMoreView = StockRankMoreView(frame: CGRect.zero, category: category, marketType: marketType)
        let _ = self.view + stockRankMoreView
    }
    
    override func updateViewConstraints() {
        
        stockRankMoreView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        super.updateViewConstraints()
    }
    
    func initRefreshControl() {
        refreshControl.setIndicatorType(.white)
        refreshControl.bindViewModel(stockRankMoreView.viewModel.refreshVM)
        refreshControl.applyNavBarConstraints(size: CGSize(width: 32, height: 32))
    }
    
    override func configuraRightNavigationItem() {
        self.navigationItem.rightBarButtonItems = [BaseBarButtonItem(customView: refreshControl)]
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
