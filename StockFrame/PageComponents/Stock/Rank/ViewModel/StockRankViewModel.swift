//
//  StockRankViewModel.swift
//  StockFrame
//
//  Created by fdt on 2018/7/19.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class StockRankViewModel: BaseViewModel {
    
    static let SECTION_CELL = "section_cell" //真实数据
    static let SECTION_MARKET = "section_market"
    static let SECTION_CATEGORY = "section_category"
    static let SECTION_CELL_TYPE = "section_cell_type"
    
    //viewModel 内部使用
    fileprivate var _refreshVM: FDTRefreshControlViewModel!
    var refreshVM: FDTRefreshControlViewModel {
        get {
            _refreshVM = createRefreshViewModel()
            return _refreshVM
        }
    }
    var sectionArray: Array<Dictionary<String, Any>>!
    var sectionFoldedFlagArray = [Bool]()
    override init() {
        super.init()
        sectionArray = Array<Dictionary<String, Any>>()
        if let marketTypes = getMarketTypes() {
            for market in marketTypes {
                if let rankInfo = getRankInfo(market) {
                    for info in rankInfo {
                        sectionArray.append(
                            [StockRankViewModel.SECTION_CELL:[],
                             StockRankViewModel.SECTION_MARKET:market,
                             StockRankViewModel.SECTION_CATEGORY:info.category.rawValue,
                             StockRankViewModel.SECTION_CELL_TYPE:info.category.cellType
                            ])
                        sectionFoldedFlagArray.append(false)
                    }
                }
            }
        }
    }
    
    override func active() {
        //
        DataCenter.sharedInstance.addObserver(.UPDATE_QUOTE_AND_RANK, observer: self, sec: #selector(handleNotification(_:)))
        _refreshVM.startProcess(nil)
    }
    
    override func deactive() {
        //
        DataCenter.sharedInstance.removeObserver(.UPDATE_QUOTE_AND_RANK, observer: self)
        _refreshVM.reset()
    }
    
    func startRequest()
    {
        if let marketTypes = getMarketTypes() {
            for market in marketTypes {
                if let rankInfo = getRankInfo(market) {
                    for info in rankInfo {
                        DataCenter.sharedInstance.doGetQuoteAndRank(market.rawValue, categories: [info])
                    }
                }
            }
        }
    }
    
    func createRefreshViewModel() -> FDTRefreshControlViewModel
    {
        preconditionFailure("This method must be overridden")
    }
    
    
    //MARK: Public
    
    /// 获取每个section的数目
    ///
    /// - Parameter section: 索引
    /// - Returns: 数目
    func getCellCount(_ section: Int) -> Int {
        if sectionFoldedFlagArray[section] {
            return 0
        }
        let cells = sectionArray[section][StockRankViewModel.SECTION_CELL] as! Array<AnyObject>
        return cells.count
    }
    
    func getCellType(_ section: Int) -> TableViewCellType {
        return sectionArray[section][StockRankViewModel.SECTION_CELL_TYPE] as! TableViewCellType
    }
    
    func getSectionCatagary(_ section: Int) -> RankingCategory {
        let category = self.sectionArray[section][StockRankViewModel.SECTION_CATEGORY] as! String
        return RankingCategory(rawValue: category)!
    }
    
    func getSectionMarketType(_ section: Int) -> MarketType {
        if let marketType = self.sectionArray[section][StockRankViewModel.SECTION_MARKET] as? MarketType {
            return marketType
        }
        return .SH
    }
    
    func getCellViewModel(_ section: Int, row: Int) -> BaseViewModel
    {
        let cells = self.sectionArray[section][StockRankViewModel.SECTION_CELL] as! Array<BaseViewModel>
        return cells[row]
    }
    
    func getCellSymbolId(_ section: Int, row: Int) -> String
    {
        let cells = self.sectionArray[section][StockRankViewModel.SECTION_CELL] as! Array<BaseViewModel>
        if let viewModel = cells[row] as? StockRankCellViewModel {
            return viewModel.symbolID
        } else if let viewModel = cells[row] as? StockRankAHCellViewModel {
            return viewModel.symbolID
        }
        return ""
    }
    ///该页面所需市场
    func getMarketTypes() -> [MarketType]? {
        preconditionFailure("This method must be overridden")
    }
    
    func getSectionTitle(_ section: Int) -> String {
        let marketType = self.getSectionMarketType(section)
        let category = self.getSectionCatagary(section)
        return category.title(marketType)
    }
    
    func getSectionViewStyle(_ section: Int) -> NomalSectionViewStyle {
        
        let marketType = self.getSectionMarketType(section)
        let category = self.getSectionCatagary(section)
        
        if marketType == .Globle {
            return .noMore
        }
        
        if category == .ETF {
            return .toast
        }
        
        return .normal
    }
    
    
    /// 获取当前section折叠状态
    ///
    /// - Parameter section: section 索引
    /// - Returns: true 折叠 false 展开
    func getSectionFolded(_ section:Int) -> Bool
    {
        if (section < sectionArray.count)
        {
            return self.sectionFoldedFlagArray[section]
        }
        return false
    }
    
    func setSectionFolded(_ section:Int)
    {
        self.sectionFoldedFlagArray[section] = !self.sectionFoldedFlagArray[section]
    }
    ///设置参数
    func getRankInfo(_ market:MarketType) -> [(category:RankingCategory, sort:FDTSortType)]?
    {
        preconditionFailure("This method must be overridden")
    }
    
    func findSectionIndex(_ sectionCategory: String,market:MarketType) -> Int
    {
        for index in 0 ... self.sectionArray.count - 1
        {
            if self.sectionArray[index][StockRankViewModel.SECTION_CATEGORY] as! String  == sectionCategory &&
                self.sectionArray[index][StockRankViewModel.SECTION_MARKET] as! MarketType == market
            {
                return index
            }
        }
        return -1
    }
    
    // MARK: Handle Notification
    @objc func handleNotification(_ notification: Notification) {
        guard let item = notification.object as? WmQuoteGroupRankingItem else {
            return
        }
        if let marketType = MarketType(rawValue: item.type) {
            if !(getMarketTypes()!.contains(marketType)) || item.level != 0 {
                return
            }
            _refreshVM.stopProcess()
            let sections: Array<String> = item.getCategoryList()
            for sectionCategory in sections
            {
                let index = findSectionIndex(sectionCategory, market: marketType)
                if index == -1 {
                    continue
                }
                
                let category = RankingCategory.getRankingCategory(sectionCategory)!
                let datas: Array<WmGroupCategoryBaseItem> = item.getDataWithCategoryId(sectionCategory)
                var cells: Array<AnyObject> = Array<AnyObject>()
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
                sectionArray[index][StockRankViewModel.SECTION_CELL] = cells as AnyObject
            }
            self.notifiedToUI()
        }
    }
}
