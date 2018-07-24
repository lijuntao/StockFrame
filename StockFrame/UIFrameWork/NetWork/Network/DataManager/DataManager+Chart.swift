//
//  DataManager+Chart.swift
//  StockFrame
//
//  Created by fdt on 2018/7/24.
//  Copyright © 2018年 ljt. All rights reserved.
//

import Foundation

extension DataManager {
    
    //处理chart数据
    func handleChartUpdate(_ packet: JPacketReceiveBase) {
        let pkt = packet as! ChartUpdate
        let period = FDTOCTools.getEnumChartPeriod(from: pkt.period)
        queue.async(flags: .barrier) {
            let symbolsItems = self.chartListDic[pkt.symbolID]
            //第一次载入数据 symbol就不存在
            if symbolsItems == nil {
                let items = [String: [ChartLineItem]] ()
                self.chartListDic[pkt.symbolID] = items
            }
            
            let periodItems = self.chartListDic[pkt.symbolID]![String(period.rawValue)]
            //symbol存在 图标数据不存在
            if periodItems == nil {
                let items = pkt.d as! [ChartLineItem]
                self.chartListDic[pkt.symbolID]![String(period.rawValue)] = items
            }
            
            var chartItems = self.chartListDic[pkt.symbolID]![String(period.rawValue)]!
            if period == .DC {
                //更新分时线图
                self.updateChartLineItem(chartItems: &chartItems, packet: pkt)
            }
            print("-------")
            for item in chartItems {
                print(item.hhmm)
            }
            print("--------")
        }
    }
    
    //更新分时图
    func updateChartLineItem(chartItems: inout [ChartLineItem], packet: ChartUpdate) {
        //如果相等说明是第一次赋值 不用更新
        if chartItems.count == packet.d.count {
            return
        }
        //如果不相等，则先判断packet数据包的时间是否在session 盘中
        //如果不在盘中也直接返回
        
        
        //到此判断是否是新的数据，如果是新的数据则直接加上去，如果不行则更新最后一条数据
        let lastItem = chartItems.last!
        if let item = packet.d.first {
            let newItem = item as! ChartLineItem
            if lastItem.hhmm != newItem.hhmm {
                chartItems.append(newItem)
            } else {
                chartItems.removeLast()
                chartItems.append(newItem)
            }
        }
    }
}
