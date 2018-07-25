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
            //symbol存在 图表数据不存在
            if periodItems == nil {
                let items = pkt.d as! [ChartLineItem]
                self.chartListDic[pkt.symbolID]![String(period.rawValue)] = items
            }
            
            var chartItems = self.chartListDic[pkt.symbolID]![String(period.rawValue)]!
            if period == .DC {
                //更新分时线图
                self.updateChartLineItem(chartItems: &chartItems, packet: pkt)
            }
            //更新过后重新赋值
            self.chartListDic[pkt.symbolID]![String(period.rawValue)] = chartItems
            
            self.postDelegate.postNotification(withType: .UPDATE_TICK, object: nil)
            let newchartItems = self.chartListDic[pkt.symbolID]![String(period.rawValue)]!
            print("-------")
            for item in newchartItems {
                print("----\(item.dataTime)")
                print("----\(item.trddate)")
            }
            print("-----count--\(newchartItems.count)")
            print("-----last--\(newchartItems.last?.dataTime)")
            print("--------")
        }
    }
    
    //更新分时图
    func updateChartLineItem(chartItems: inout [ChartLineItem], packet: ChartUpdate) {
        //更新数据为空 直接返回
        if packet.d.count <= 0 {
            return
        }
        
        let newItems = packet.d as! [ChartLineItem]
        //如果不是同一个交易日的数据 清空原来的数据
        if chartItems.count > 0 {
            let oldData = (chartItems.first!).trddate
            let newData = (newItems.first!).trddate
            if oldData != newData {
                chartItems.removeAll()
                chartItems = newItems
            }
        }
        
        //如果相等说明是第一次赋值 不用更新
        if chartItems.count == newItems.count {
            return
        }
        
        
        //如果不相等，则先判断packet数据包的时间是否在session盘中
        //如果不在盘中也直接返回
        if !FDTOCTools.timeIs(inSession: newItems.last?.dataTime , withSession: newItems.last?.session) {
            //
            return
        }
        
        //到此判断是否是新的数据，如果是新的数据则直接加上去，如果不行则更新最后一条数据
        let lastItem = chartItems.last!
        if let item = packet.d.first {
            let newItem = item as! ChartLineItem
            if lastItem.dataTime != newItem.dataTime {
                chartItems.append(newItem)
            } else {
                chartItems.removeLast()
                chartItems.append(newItem)
            }
        }
    }
}
