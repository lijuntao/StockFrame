//
//  StockRankHSViewModel.swift
//  StockFrame
//
//  Created by fdt on 2018/7/19.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class StockRankHSViewModel: StockRankViewModel {

    override func getMarketTypes() -> [MarketType]? {
        return [.SH,.SZ]
    }
    
    override func getRankInfo(_ market: MarketType) -> [(category: RankingCategory, sort: FDTSortType)]? {
        if(market == .SH){
            return [(RankingCategory.Amt, FDTSortType.descending),
                    (RankingCategory.SH, FDTSortType.descending),
                    (RankingCategory.Down, FDTSortType.ascending)]
        }
        return [(RankingCategory.Amt, FDTSortType.descending),
                (RankingCategory.Up, FDTSortType.descending),
                (RankingCategory.Down, FDTSortType.ascending)]
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
