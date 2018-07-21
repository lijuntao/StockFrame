//
//  StockRankUSViewModel.swift
//  StockFrame
//
//  Created by fdt on 2018/7/21.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class StockRankUSViewModel: StockRankViewModel {

    override func getMarketTypes() -> [MarketType]? {
        return [.USD]
    }
    
    override func getRankInfo(_ market: MarketType) -> [(category: RankingCategory, sort: FDTSortType)]? {
        return [(RankingCategory.China, FDTSortType.descending),
                (RankingCategory.Star, FDTSortType.descending),
                (RankingCategory.ETF, FDTSortType.descending)]
    }
    
    override func createRefreshViewModel() -> FDTRefreshControlViewModel
    {
        let vm = FDTRefreshControlViewModel()
        vm.setCountingMode(true)
        vm.setTimeInterval(3)
        vm.setProcess { [unowned self] _ in
            self.startRequest()
        }
        return vm
    }
}
