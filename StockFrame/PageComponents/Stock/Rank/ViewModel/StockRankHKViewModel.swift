//
//  StockRankHKViewModel.swift
//  StockFrame
//
//  Created by fdt on 2018/7/21.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class StockRankHKViewModel: StockRankViewModel {

    override func getMarketTypes() -> [MarketType]? {
        return [.HK]
    }
    
    override func getRankInfo(_ market: MarketType) -> [(category: RankingCategory, sort: FDTSortType)]? {
        return [(RankingCategory.MainAMT, FDTSortType.descending),
                (RankingCategory.MainUp, FDTSortType.descending),
                (RankingCategory.MainDown, FDTSortType.ascending),
                (RankingCategory.AH, FDTSortType.descending),
                (RankingCategory.ETF, FDTSortType.descending)
        ]
    }
    
    override func createRefreshViewModel() -> FDTRefreshControlViewModel
    {
        let vm = FDTRefreshControlViewModel()
        vm.setCountingMode(false)
        vm.setProcess { [unowned self] _ in
            self.startRequest()
        }
        return vm
    }
}
