//
//  ChartLineViewModel.swift
//  StockFrame
//
//  Created by fdt on 2018/7/27.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class ChartLineViewModel: BaseViewModel {

    var preClosePrice: CGFloat? //昨收价
    var lineCount: Int? //分钟数
    var maxPrice: CGFloat = 0.0 //最高价 初始化为0
    var maxPricePersent: CGFloat = 0.0
    var minPrice: CGFloat = 99999999999.0 //最低价 初始化一个不可能达到的最大值
    var minPricePersent: CGFloat = 0.0
    var minVolume: CGFloat = 0.0 //最大成交量
    var maxVolume: CGFloat = 0.0 //最低成交量
    var lineItems = [ChartLineItem]()
    var period = EnumChartPeriod.DC
    var symbolId = ""
    var marketType = MarketType.SZ
    init(symbolId: String, period: EnumChartPeriod) {
        super.init()
        self.symbolId = symbolId
        self.period = period
        self.marketType = DataCenter.sharedInstance.getSymboMarketType(symbolId: symbolId)
    }
    
    convenience override init() {
        self.init(symbolId: "000002.SZ.WM", period: .DC)
    }
    
    override func active() {
        DataCenter.sharedInstance.addObserver(.UPDATE_TICK, observer: self, sec: #selector(handleNotification(_:)))
        DataCenter.sharedInstance.addObserver(.UPDATE_QUOTE, observer: self, sec: #selector(handleNotification(_:)))
        DataCenter.sharedInstance.doQuoteRef([symbolId])
        DataCenter.sharedInstance.doTickRef([symbolId], period: period)
    }
    
    override func deactive() {
        DataCenter.sharedInstance.doTickUnRef([symbolId], period: period)
        DataCenter.sharedInstance.doQuoteUnRef([symbolId])
        DataCenter.sharedInstance.removeObserver(.UPDATE_TICK, observer: self)
        DataCenter.sharedInstance.removeObserver(.UPDATE_QUOTE, observer: self)
    }
    
    func getTimePosition() -> Array<Dictionary<String,Any>> {
        switch marketType {
        case .SH, .SZ:
            return [["pos":0,"time":"09:30"],
                    ["pos":60,"time":"10:30"],
                    ["pos":120,"time":"11:30"],
                    ["pos":181,"time":"14:00"],
                    ["pos":241,"time":"15:30"]]
        case .USD:
            return [["pos":0,"time":"21:30"],
                    ["pos":180,"time":"00:30"],
                    ["pos":390,"time":"04:00"]]
        case .HK:
            return [["pos":0,"time":"09:30"],
                    ["pos":150,"time":"12:00"],
                    ["pos":341,"time":"16:10"]]
        default:
            return []
        }
    }
    
    // MARK: Handle Notification
    @objc func handleNotification(_ notification: Notification) {
        //先获取preClosePrice昨收价
        //如果昨收价已经有了 就不用再去获取了
        if preClosePrice == nil {
            if let quoteItem = DataCenter.sharedInstance.getQuoteItem(symbolId: symbolId) {
                if quoteItem.preClose.valid {
                    if let doublePreClosePrice = Double(quoteItem.preClose.text) {
                        preClosePrice = CGFloat(doublePreClosePrice)
                    }
                }
            }
            //如果分时数据还没有则直接返回
            if lineItems.count <= 0 {
                return
            }
        }
        
        //获取分时数据
        if let items = DataCenter.sharedInstance.getChartItem(symbolId: symbolId, period: .DC), (items.count > 0) {
            lineItems = items
            //计算分钟数
            if lineCount == nil {
                lineCount = FDTOCTools.countMin(inSession: lineItems.first?.session)
            }
            
            //计算最大值 最小值
            for item in items {
                let closeValue = CGFloat(item.close.floatValue)
                if closeValue > maxPrice {
                    maxPrice = closeValue
                }
                if closeValue < minPrice {
                    minPrice = closeValue
                }
                let volumeValue = CGFloat(item.volume.floatValue)
                if volumeValue > maxVolume {
                    maxVolume = volumeValue
                }
            }
            //重新设置最大值最小值使昨收价位于中间
            let maxDiff = abs(maxPrice - preClosePrice!)
            let minDiff = abs(minPrice - preClosePrice!)
            maxPrice = maxDiff > minDiff ? preClosePrice! + maxDiff : preClosePrice! + minDiff
            minPrice = maxDiff > minDiff ? preClosePrice! - maxDiff : preClosePrice! - minDiff
            
            //最大值最小值上下浮动10%
            let unit100Y = (maxPrice - minPrice) / 100.0
            maxPrice = maxPrice + 0.5 * unit100Y
            minPrice = minPrice - 0.5 * unit100Y
            
            maxPricePersent = (maxPrice - preClosePrice!) / preClosePrice! * 100
            minPricePersent = (minPrice - preClosePrice!) / preClosePrice! * 100
            
//            print("-------")
//            print("-----preClosePrice--\(preClosePrice!)")
//            print("-----maxPrice--\(maxPrice)")
//            print("-----minPrice--\(minPrice)")
//            print("-----maxPricePersent--|\(maxPricePersent)")
//            print("-----minPricePersent--|\(minPricePersent)")
//            print("-----count--\(lineItems.count)")
//            print("-----last--\(lineItems.last?.dataTime!)")
//            print("--------")
            //通知刷新UI
            self.notifiedToUI()
        }
    }
}
