//
//  StockRankMoreViewModel.swift
//  StockFrame
//
//  Created by fdt on 2018/7/22.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class StockRankMoreViewModel: BaseViewModel {

    var cellArray: Array<BaseViewModel>!
    var marketType: MarketType!
    var category: RankingCategory!
    var sortType: FDTSortType = FDTSortType.descending
    var _refreshVM: FDTRefreshControlViewModel!
    var refreshVM: FDTRefreshControlViewModel {
        get {
            _refreshVM = createRefreshViewModel()
            return _refreshVM
        }
    }
    
    override func active() {
        //
        DataCenter.sharedInstance.addObserver(.OBSERVER_UPDATE_QUOTE_AND_RANK, observer: self, sec: #selector(handleNotification(_:)))
        _refreshVM.startProcess(nil)
    }
    
    override func deactive() {
        //
        DataCenter.sharedInstance.removeObserver(.OBSERVER_UPDATE_QUOTE_AND_RANK, observer: self)
        _refreshVM.reset()
    }
    
    func startRequest()
    {
        DataCenter.sharedInstance.doGetQuoteAndRank(marketType.rawValue, categories: [(category,sortType)],level: 1)
    }
    
    func getSectionTitles() -> [String] {
        switch category {
        case .SH, .Up, .Down, .MainUp, .MainDown, .ETF, .China, .Star:
            return ["名称代码","最新价","涨跌%"]
        default:
            return ["名称代码","最新价","成交额"]
        }
        
    }
    
    func getSortType() -> FDTSortType {
        return sortType
    }
    
    func sortBy()
    {
        if sortType == FDTSortType.ascending
        {
            sortType = FDTSortType.descending
        }
        else
        {
            sortType = FDTSortType.ascending
        }
        _refreshVM.stopProcess()
        _refreshVM.startProcess(nil)
    }
    
    init(category: RankingCategory, marketType: MarketType)
    {
        super.init()
        cellArray = Array<StockRankCellViewModel>()
        self.category = category
        self.marketType = marketType
        
        if category == RankingCategory.MainDown
        {
            sortType = FDTSortType.ascending
        }
        else if category == RankingCategory.MainUp
        {
            sortType = FDTSortType.descending
        }
        else if category == RankingCategory.SH
        {
            sortType = FDTSortType.descending
        }
        else if category == RankingCategory.MainAMT
        {
            sortType = FDTSortType.descending
        }else if category == RankingCategory.Down
        {
            sortType = FDTSortType.ascending
        }
        else
        {
            sortType = FDTSortType.descending
        }
        if(marketType == .SZ){
            if(category == RankingCategory.Down){
                sortType = FDTSortType.ascending;
            }
        }
    }
    
    func createRefreshViewModel() -> FDTRefreshControlViewModel
    {
        let vm = FDTRefreshControlViewModel()
        if marketType == .HK {
            vm.setCountingMode(false)
        } else {
            vm.setCountingMode(true)
            vm.setTimeInterval(3)
        }
        vm.setProcess { [unowned self] _ in
            self.startRequest()
        }
        return vm
    }
    
    // MARK: Handle Notification
    @objc func handleNotification(_ notification: Notification) {
        guard let item = notification.object as? WmQuoteGroupRankingItem else {
            return
        }
        _refreshVM.stopProcess()
        if item.type != marketType.rawValue
        {
            return
        }
        
        let sections: Array<String> = item.getCategoryList()
        
        if sections.count != 1 || sections[0] != category.rawValue
        {
            return
        }
        _refreshVM.stopProcess()
        let datas: Array<WmGroupCategoryBaseItem> = item.getDataWithCategoryId(category.rawValue)
        var cells = Array<BaseViewModel>()
        for data in datas
        {
            if category == .AH {
                let vm = StockRankAHCellViewModel()
                vm.setDataItem(data)
                cells.append(vm)
            } else {
                let vm = StockRankCellViewModel()
                vm.setDataItem(data)
                cells.append(vm)
            }
            
        }
        
        cellArray = cells
        self.notifiToUI()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}
