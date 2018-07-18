//
//  DataManger+QuoteUpdate.swift
//  StockFrame
//
//  Created by fdt on 2018/7/17.
//  Copyright © 2018年 ljt. All rights reserved.
//

import Foundation

extension DataManager {
    
    
    /// 保存 MarketStatus 状态
    ///
    /// - Parameter packet: 接收数据包
    func handleMarketStatus(_ packet:JPacketReceiveBase) {
        let pkt = packet as! MarketStatusUpdate
        queue.async(flags: .barrier) {
            var dic:[String:Int] = [:]
            if self.marketStatueDic.keys.contains(pkt.ex) {
                dic = self.marketStatueDic[pkt.ex]!
            }
            dic[pkt.sesname] = pkt.status
            self.marketStatueDic[pkt.ex] = dic
        }
    }
}
