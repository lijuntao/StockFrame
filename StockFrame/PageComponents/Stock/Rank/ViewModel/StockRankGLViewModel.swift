//
//  StockRankGLViewModel.swift
//  StockFrame
//
//  Created by fdt on 2018/7/21.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class StockRankGLViewModel: StockRankViewModel {
    
    override func getMarketTypes() -> [MarketType]? {
        return [.Globle]
    }
    
    override func getRankInfo(_ market: MarketType) -> [(category: RankingCategory, sort: FDTSortType)]? {
        return [(RankingCategory.Common, FDTSortType.none),
                (RankingCategory.Western, FDTSortType.none),
                (RankingCategory.Forex, FDTSortType.none),
                (RankingCategory.Cny, FDTSortType.none)]
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
