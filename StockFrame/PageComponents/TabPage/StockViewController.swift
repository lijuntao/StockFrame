//
//  StockViewController.swift
//  StockFrame
//
//  Created by fdt on 2018/6/27.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class StockViewController: ViewControllerBase, UIScrollViewDelegate, TabsSegmentProtocol {
    
    var tabs = ["沪深","港股","美股","全球"]
    var tabsSegment: TabsSegment!
    
    var mainScrollContentView: BaseView!
    var mainScrollView:  BaseScrollView!
    
    var stockRankViewHS: StockRankView!
    var stockRankViewHK: StockRankView!
    var stockRankViewUS: StockRankView!
    var stockRankViewGL: StockRankView!
    var currentStockRankView: StockRankView!
    
    var refreshControlHS = FDTRefreshControl()
    var refreshControlHK = FDTRefreshControl()
    var refreshControlUS = FDTRefreshControl()
    var refreshControlGl = FDTRefreshControl()
    
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
        currentStockRankView.activeViewModel()
    }
    
    func deactiveView() {
        currentStockRankView.deactiveViewModel()
    }

    // MARK: Privite
    func initView() {
        
        tabsSegment = TabsSegment(tabs: tabs)
        tabsSegment.delegate = self
        let _ = self.view + tabsSegment
        
        mainScrollContentView = BaseView()
        mainScrollContentView.backgroundColor = FDTWMColor.backgroundColor.color
        
        mainScrollView = BaseScrollView()
        mainScrollView.isPagingEnabled = true
        mainScrollView.isScrollEnabled = true
        mainScrollView.delegate = self
        
        stockRankViewHS = StockRankView(frame: CGRect.zero, viewModel: StockRankHSViewModel())
        stockRankViewHK = StockRankView(frame: CGRect.zero, viewModel: StockRankHKViewModel())
        stockRankViewUS = StockRankView(frame: CGRect.zero, viewModel: StockRankUSViewModel())
        stockRankViewGL = StockRankView(frame: CGRect.zero, viewModel: StockRankGLViewModel())
        
        currentStockRankView = stockRankViewHS
        
        let _ = mainScrollContentView + [stockRankViewHS, stockRankViewHK, stockRankViewUS, stockRankViewGL]
        let _ = mainScrollView + mainScrollContentView
        let _ = self.view + mainScrollView
    }
    
    override func configuraRightNavigationItem() {
        self.initRefreshControl()
        switch currentStockRankView {
        case stockRankViewHS:
            self.navigationItem.rightBarButtonItems = [BaseBarButtonItem(customView: refreshControlHS)]
        case stockRankViewHK:
            self.navigationItem.rightBarButtonItems = [BaseBarButtonItem(customView: refreshControlHK)]
        case stockRankViewUS:
            self.navigationItem.rightBarButtonItems = [BaseBarButtonItem(customView: refreshControlUS)]
        case stockRankViewGL:
            self.navigationItem.rightBarButtonItems = [BaseBarButtonItem(customView: refreshControlGl)]
        default:
            //
            self.navigationItem.rightBarButtonItems = []
            break
        }
    }
    
    override func updateViewConstraints() {
        
        tabsSegment.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(Layout.ui.regularSectionHeight)
        }
        
        mainScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(tabsSegment.snp.bottom)
            make.bottom.left.right.equalToSuperview()
        }
        
        mainScrollContentView.snp.makeConstraints { (make) in
            make.top.equalTo(tabsSegment.snp.bottom)
            make.left.equalTo(mainScrollView)
            make.bottom.equalTo(self.view)
        }
        
        stockRankViewHS.snp.makeConstraints { (make) in
            make.top.equalTo(mainScrollContentView)
            make.left.equalTo(mainScrollContentView)
            make.bottom.equalTo(self.view)
            make.width.equalTo(tabsSegment.snp.width)
        }
        
        stockRankViewHK.snp.makeConstraints { (make) in
            make.top.equalTo(mainScrollContentView)
            make.left.equalTo(stockRankViewHS.snp.right)
            make.bottom.equalTo(self.view)
            make.width.equalTo(tabsSegment.snp.width)
        }
        
        stockRankViewUS.snp.makeConstraints { (make) in
            make.top.equalTo(mainScrollContentView)
            make.left.equalTo(stockRankViewHK.snp.right)
            make.bottom.equalTo(self.view)
            make.width.equalTo(tabsSegment.snp.width)
        }
        
        
        stockRankViewGL.snp.makeConstraints { (make) in
            make.top.equalTo(mainScrollContentView)
            make.left.equalTo(stockRankViewUS.snp.right)
            make.bottom.equalTo(self.view)
            make.width.equalTo(tabsSegment.snp.width)
            make.right.equalTo(mainScrollContentView)
        }
        
        super.updateViewConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        mainScrollView.contentSize = mainScrollContentView.frame.size
    }
    
    
    func initRefreshControl() {
        guard let _ = currentStockRankView else {
            return
        }
        refreshControlHS.setIndicatorType(.white)
        refreshControlHK.setIndicatorType(.white)
        refreshControlUS.setIndicatorType(.white)
        refreshControlGl.setIndicatorType(.white)
        
        refreshControlHS.bindViewModel(stockRankViewHS.viewModel.refreshVM)
        refreshControlHK.bindViewModel(stockRankViewHK.viewModel.refreshVM)
        refreshControlUS.bindViewModel(stockRankViewUS.viewModel.refreshVM)
        refreshControlGl.bindViewModel(stockRankViewGL.viewModel.refreshVM)
        
        refreshControlHS.applyNavBarConstraints(size: CGSize(width: 32, height: 32))
        refreshControlHK.applyNavBarConstraints(size: CGSize(width: 32, height: 32))
        refreshControlUS.applyNavBarConstraints(size: CGSize(width: 32, height: 32))
        refreshControlGl.applyNavBarConstraints(size: CGSize(width: 32, height: 32))
    }
    
    //MARK: UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //
        let index = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        if index >= 0  {
            tabsSegment.setBtnActionIndex(index)
        }
    }
    
    //MAKR: TabsSegmentProtocol
    func tabsActiveIndex(_ index: Int) {
        currentStockRankView.deactiveViewModel()
        switch index {
        case 0:
            currentStockRankView = stockRankViewHS
        case 1:
            currentStockRankView = stockRankViewHK
        case 2:
            currentStockRankView = stockRankViewUS
        case 3:
            currentStockRankView = stockRankViewGL
        default:
            break
        }
        self.configuraRightNavigationItem() //activeViewModel之前，重新绑定refreshModel关系
        currentStockRankView.activeViewModel()
        
        
        mainScrollView.isUserInteractionEnabled = false
        mainScrollView.setContentOffset(CGPoint(x: CGFloat(index) * self.view.bounds.size.width, y: 0), animated: true)
        let delayTime = DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) { () -> Void in
            //延迟3秒，执行的操作
            self.mainScrollView.isUserInteractionEnabled = true;
        }
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
