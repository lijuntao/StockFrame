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
    
    /// 榜单返回处理
    ///
    /// - Parameter packet: 数据包
    func handleWmQuoteAndRankUpdate(_ packet:JPacketReceiveBase) {
        let pkt = packet as! WmQuoteAndRankUpdate
        let item = WmQuoteGroupRankingItem.init()
        item.type = pkt.type
        for categoryCore in pkt.categories! {
            if categoryCore.data?.count == 0 {
                let empty = WmGroupCategoryBaseItem.init()
                empty.isEmpty = true
                item.addIndustryOrSymbol(empty, category: categoryCore.id, level: categoryCore.level)
            } else {
                var language = "CN"
                switch FDTOCTools.getDeviceLanguage() {
                case .CN:
                    language = "CN"
                case .TW:
                    language = "TW"
                case .EN:
                    language = "EN"
                }
                
                let category = RankingCategory(rawValue: categoryCore.id)!
                switch category {
                case .Industry:
                    for dataCore in categoryCore.data! {
                        let symbolItem = WmGroupCategoryIndustryItem.init()
                        symbolItem.fillData(dataCore, withLanguage: language)
                        item.addIndustryOrSymbol(symbolItem, category: categoryCore.id, level: categoryCore.level)
                    }
                case .MainAMT:
                    for dataCore in categoryCore.data! {
                        let symbolItem = WmGroupCategorySymbolItem.init()
                        symbolItem.fillData(dataCore, withLanguage: language)
                        item.addIndustryOrSymbol(symbolItem, category: categoryCore.id, level: categoryCore.level)
                    }
                case .Amt:
                    for dataCore in categoryCore.data! {
                        let symbolItem = WmGroupCategoryAmountItem.init()
                        symbolItem.fillData(dataCore, withLanguage: language)
                        item.addIndustryOrSymbol(symbolItem, category: categoryCore.id, level: categoryCore.level)
                    }
                case .Forex, .Cny:
                    for dataCore in categoryCore.data! {
                        let symbolItem = WmGroupCategoryForexItem.init()
                        symbolItem.fillData(dataCore, withLanguage: language)
                        item.addIndustryOrSymbol(symbolItem, category: categoryCore.id, level: categoryCore.level)
                    }
                case .AH:
                    for dataCore in categoryCore.data! {
                        let symbolItem = WmGroupCategoryAHStockItem.init()
                        symbolItem.fillData(dataCore, withLanguage: language)
                        item.addIndustryOrSymbol(symbolItem, category: categoryCore.id, level: categoryCore.level)
                    }
                case .Turnover:
                    for dataCore in categoryCore.data! {
                        let symbolItem = WmGroupCategoryTurnoverItem.init()
                        symbolItem.fillData(dataCore, withLanguage: language)
                        item.addIndustryOrSymbol(symbolItem, category: categoryCore.id, level: categoryCore.level)
                    }
                default:
                    for dataCore in categoryCore.data! {
                        let symbolItem = WmGroupCategorySymbolItem.init()
                        symbolItem.fillData(dataCore, withLanguage: language)
                        item.addIndustryOrSymbol(symbolItem, category: categoryCore.id, level: categoryCore.level)
                    }
                }
            }    
        }
        self.postDelegate.postNotification(withType: .UPDATE_QUOTE_AND_RANK, object: item)
    }
    
    func handleQuoteUpdate(_ packet:JPacketReceiveBase) {
        let pkt = packet as! QuoteUpdate
        
        queue.async(flags: .barrier) {
            var quoteItem = self.quoteListDic[pkt.id]
            if quoteItem == nil {
                quoteItem = JQuoteItem()
                self.quoteListDic[pkt.id] = quoteItem!
            }
            
            quoteItem?.stale = pkt.stale
            quoteItem?.status = pkt.status
            
            //交易日期
            repeat {
                if pkt.tdate == JPacket_INVALID {
                    break
                }
                let strText = String(format: "%d", pkt.tdate)
                let item = QuoteFieldItem.init(text: strText)
                quoteItem?.tradingDate = item
            } while (false)
            
            //FID_TradingTime
            repeat {
                let strText = pkt.d[EnumFieldID.FID_TradingTime.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.tradingTime = item
            } while (false)
            
            //总量
            repeat {
                let strText = pkt.d[EnumFieldID.FID_TotalVolume.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.totalVolume = item
            } while (false)
            
            // 昨收
            repeat {
                let strText = pkt.d[EnumFieldID.FID_PreClose.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.preClose = item
            } while (false)
            
            // 成交
            repeat {
                let strText = pkt.d[EnumFieldID.FID_Price.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.price = item
            } while (false)
            
            // Price or PreClose
            repeat {
                var strText: String?
                if (quoteItem?.price.valid)! {
                    strText = quoteItem?.price.text
                } else if (quoteItem?.preClose.valid)! {
                    strText = quoteItem?.preClose.text
                } else {
                    break
                }
                let item = QuoteFieldItem.init(text: strText)
                quoteItem?.priceorPreClose = item
            } while (false)
            
            // FID_PriceChange
            repeat {
                let strText = pkt.d[EnumFieldID.FID_PriceChange.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.priceChange = item
            } while (false)
            
            // FID_PriceChange
            repeat {
                let strText = pkt.d[EnumFieldID.FID_PriceChange.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.priceChange = item
            } while (false)
            
            // FID_PriceChangeRatio
            repeat {
                let strText = pkt.d[EnumFieldID.FID_PriceChangeRatio.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.priceChangeRatio = item
            } while (false)
            
            // FID_EN_Name
            repeat {
                let strText = pkt.d[EnumFieldID.FID_EN_Name.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.en_Name = item
            } while (false)
            
            // FID_CN_Name
            repeat {
                let strText = pkt.d[EnumFieldID.FID_CN_Name.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.cn_Name = item
            } while (false)
            
            // FID_TW_Name
            repeat {
                let strText = pkt.d[EnumFieldID.FID_TW_Name.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.tw_Name = item
            } while (false)
            
            // FID_Bid
            repeat {
                let strText = pkt.d[EnumFieldID.FID_Bid.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.bid = item
            } while (false)
            
            // FID_Ask
            repeat {
                let strText = pkt.d[EnumFieldID.FID_Ask.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.ask = item
            } while (false)
            
            // FID_BidVolume
            repeat {
                let strText = pkt.d[EnumFieldID.FID_BidVolume.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.bidVolume = item
            } while (false)
            
            // FID_AskVolume
            repeat {
                let strText = pkt.d[EnumFieldID.FID_AskVolume.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.askVolume = item
            } while (false)
            
            // FID_High
            repeat {
                let strText = pkt.d[EnumFieldID.FID_High.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.high = item
            } while (false)
            
            // FID_Low
            repeat {
                let strText = pkt.d[EnumFieldID.FID_Low.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.low = item
            } while (false)
            
            // FID_SettlePrice
            repeat {
                let strText = pkt.d[EnumFieldID.FID_SettlePrice.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.settlePrice = item
            } while (false)
            
            // FID_OpenInterest
            repeat {
                let strText = pkt.d[EnumFieldID.FID_OpenInterest.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.openInterest = item
            } while (false)
            
            // FID_Volume
            repeat {
                let strText = pkt.d[EnumFieldID.FID_Volume.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.volume = item
            } while (false)
            
            // FID_Open
            repeat {
                let strText = pkt.d[EnumFieldID.FID_Open.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.open = item
            } while (false)
            
            // FID_UpLimit
            repeat {
                let strText = pkt.d[EnumFieldID.FID_UpLimit.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.upLimit = item
            } while (false)
            
            // FID_DownLimit
            repeat {
                let strText = pkt.d[EnumFieldID.FID_DownLimit.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.downLimit = item
            } while (false)
            
            // FID_52WHigh
            repeat {
                let strText = pkt.d[EnumFieldID.FID_52WHigh.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.high52W = item
            } while (false)
            
            // FID_52WLow
            repeat {
                let strText = pkt.d[EnumFieldID.FID_52WLow.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.low52W = item
            } while (false)
            
            // FID_Amount
            repeat {
                let strText = pkt.d[EnumFieldID.FID_Amount.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.amount = item
            } while (false)
            
            // FID_BuyDealVol
            repeat {
                let strText = pkt.d[EnumFieldID.FID_BuyDealVol.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.buyDealVol = item
            } while (false)
            
            // FID_SellDealVol
            repeat {
                let strText = pkt.d[EnumFieldID.FID_SellDealVol.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.sellDealVol = item
            } while (false)
            
            // FID_SharesOut
            repeat {
                let strText = pkt.d[EnumFieldID.FID_SharesOut.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.sharesOut = item
            } while (false)
            
            // FID_NeutralDealVol
            repeat {
                let strText = pkt.d[EnumFieldID.FID_NeutralDealVol.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.neutralDealVol = item
            } while (false)
            
            // FID_BuyDealAmt
            repeat {
                let strText = pkt.d[EnumFieldID.FID_BuyDealAmt.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.buyDealAmt = item
            } while (false)
            
            // FID_SellDealAmt
            repeat {
                let strText = pkt.d[EnumFieldID.FID_SellDealAmt.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.sellDealAmt = item
            } while (false)
            
            // FID_NeutralDealAmt
            repeat {
                let strText = pkt.d[EnumFieldID.FID_NeutralDealAmt.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.neutralDealAmt = item
            } while (false)
            
            // FID_TotalCapital
            repeat {
                let strText = pkt.d[EnumFieldID.FID_TotalCapital.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.totalCapital = item
            } while (false)
            
            // FID_NetProfitMgn
            repeat {
                let strText = pkt.d[EnumFieldID.FID_NetProfitMgn.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.netProfitMgn = item
            } while (false)
            
            // FID_TurnoverRt
            repeat {
                let strText = pkt.d[EnumFieldID.FID_TurnoverRt.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.turnoverRt = item
            } while (false)
            
            // FID_ValPftRt
            repeat {
                let strText = pkt.d[EnumFieldID.FID_ValPftRt.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.valPftRt = item
            } while (false)
            
            // FID_TotalValue
            repeat {
                let strText = pkt.d[EnumFieldID.FID_TotalValue.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.totalValue = item
            } while (false)
            
            // FID_OutValue
            repeat {
                let strText = pkt.d[EnumFieldID.FID_OutValue.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.outValue = item
            } while (false)
            
            // FID_Amplitude
            repeat {
                let strText = pkt.d[EnumFieldID.FID_Amplitude.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.amplitude = item
            } while (false)
            
            // FID_DividendAmount
            repeat {
                let strText = pkt.d[EnumFieldID.FID_DividendAmount.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.dividendAmount = item
            } while (false)
            
            // FID_DividendRate
            repeat {
                let strText = pkt.d[EnumFieldID.FID_DividendRate.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.dividendRate = item
            } while (false)
            
            // FID_Beta
            repeat {
                let strText = pkt.d[EnumFieldID.FID_Beta.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.beta = item
            } while (false)
            
            // FID_TotalAssets
            repeat {
                let strText = pkt.d[EnumFieldID.FID_TotalAssets.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.totalAssets = item
            } while (false)
            
            // FID_Nav
            repeat {
                let strText = pkt.d[EnumFieldID.FID_Nav.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.nav = item
            } while (false)
            
            // FID_PremiumDiscountRate
            repeat {
                let strText = pkt.d[EnumFieldID.FID_PremiumDiscountRate.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.premiumDiscountRate = item
            } while (false)
            
            // FID_YtdReturn
            repeat {
                let strText = pkt.d[EnumFieldID.FID_YtdReturn.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.ytdReturn = item
            } while (false)
            
            // FID_ExpenseRatio
            repeat {
                let strText = pkt.d[EnumFieldID.FID_ExpenseRatio.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.expenseRatio = item
            } while (false)
            
            // FID_BidPx1
            repeat {
                let strText = pkt.d[EnumFieldID.FID_BidPx1.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.bidPx1 = item
            } while (false)
            
            // FID_AskPx1
            repeat {
                let strText = pkt.d[EnumFieldID.FID_AskPx1.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.askPx1 = item
            } while (false)
            
            // FID_BidSz1
            repeat {
                let strText = pkt.d[EnumFieldID.FID_BidSz1.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.bidSz1 = item
            } while (false)
            
            // FID_AskSz1
            repeat {
                let strText = pkt.d[EnumFieldID.FID_AskSz1.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.askSz1 = item
            } while (false)
            
            // FID_BidPx2
            repeat {
                let strText = pkt.d[EnumFieldID.FID_BidPx2.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.bidPx2 = item
            } while (false)
            
            // FID_AskPx2
            repeat {
                let strText = pkt.d[EnumFieldID.FID_AskPx2.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.askPx2 = item
            } while (false)

            // FID_BidSz2
            repeat {
                let strText = pkt.d[EnumFieldID.FID_BidSz2.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.bidSz2 = item
            } while (false)
            
            // FID_AskSz2
            repeat {
                let strText = pkt.d[EnumFieldID.FID_AskSz2.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.askSz2 = item
            } while (false)
            
            // FID_BidPx3
            repeat {
                let strText = pkt.d[EnumFieldID.FID_BidPx3.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.bidPx3 = item
            } while (false)
            
            // FID_AskPx3
            repeat {
                let strText = pkt.d[EnumFieldID.FID_AskPx3.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.askPx3 = item
            } while (false)
            
            // FID_BidSz3
            repeat {
                let strText = pkt.d[EnumFieldID.FID_BidSz3.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.bidSz3 = item
            } while (false)
            
            // FID_AskSz3
            repeat {
                let strText = pkt.d[EnumFieldID.FID_AskSz3.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.askSz3 = item
            } while (false)
            
            // FID_BidPx4
            repeat {
                let strText = pkt.d[EnumFieldID.FID_BidPx4.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.bidPx4 = item
            } while (false)
            
            // FID_AskPx4
            repeat {
                let strText = pkt.d[EnumFieldID.FID_AskPx4.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.askPx4 = item
            } while (false)
            
            // FID_BidSz4
            repeat {
                let strText = pkt.d[EnumFieldID.FID_BidSz4.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.bidSz4 = item
            } while (false)
            
            // FID_AskSz4
            repeat {
                let strText = pkt.d[EnumFieldID.FID_AskSz4.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.askSz4 = item
            } while (false)
            
            // FID_BidPx5
            repeat {
                let strText = pkt.d[EnumFieldID.FID_BidPx5.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.bidPx5 = item
            } while (false)
            
            // FID_AskPx5
            repeat {
                let strText = pkt.d[EnumFieldID.FID_AskPx5.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.askPx5 = item
            } while (false)
            
            // FID_BidSz5
            repeat {
                let strText = pkt.d[EnumFieldID.FID_BidSz5.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.bidSz5 = item
            } while (false)
            
            // FID_AskSz5
            repeat {
                let strText = pkt.d[EnumFieldID.FID_AskSz5.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.askSz5 = item
            } while (false)
            
            // rzrq
            repeat {
                let strText = pkt.d[EnumFieldID.FID_RZRQ.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.hasRzrq = item
            } while (false)
            
            // 是否有对应的港股衍生物,1有,0没有
            repeat {
                let strText = pkt.d[EnumFieldID.FID_Derivative.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.derivative = item
            } while (false)
            
            // 对应正股symbol
            repeat {
                let strText = pkt.d[EnumFieldID.FID_Underlying.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.underlyingSymbol = item
            } while (false)
            
            // 杠杆比例
            repeat {
                let strText = pkt.d[EnumFieldID.FID_LeverageRatio.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.leverageRatio = item
            } while (false)
            
            //行使价
            repeat {
                let strText = pkt.d[EnumFieldID.FID_ExercisePrice.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.exercisePrice = item
            } while (false)
            
            //对冲值
            repeat {
                let strText = pkt.d[EnumFieldID.FID_Delta.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.delta = item
            } while (false)
            
            //街货比
            repeat {
                let strText = pkt.d[EnumFieldID.FID_OutstandingQuantityRate.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.outstandingQuantityRate = item
            } while (false)
            
            //溢价
            repeat {
                let strText = pkt.d[EnumFieldID.FID_Premium.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.premium = item
            } while (false)
            
            //换股比例
            repeat {
                let strText = pkt.d[EnumFieldID.FID_ConversionRatio.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.conversionRatio = item
            } while (false)
            
            //引伸波幅
            repeat {
                let strText = pkt.d[EnumFieldID.FID_ImpliedVolatility.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.impliedVolatility = item
            } while (false)
            
            //有效杠杆
            repeat {
                let strText = pkt.d[EnumFieldID.FID_EffectiveLever.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.effectiveLever = item
            } while (false)
            
            //打和点
            repeat {
                let strText = pkt.d[EnumFieldID.FID_StrikePoint.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.strikePoint = item
            } while (false)
            
            //到期日
            repeat {
                let strText = pkt.d[EnumFieldID.FID_Maturity.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.maturity = item
            } while (false)
            
            //回收价
            repeat {
                let strText = pkt.d[EnumFieldID.FID_RecoverableValue.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.recoverableValue = item
            } while (false)
            
            //普通股票1，窝轮2，牛熊3
            repeat {
                let strText = pkt.d[EnumFieldID.FID_HkType.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.hkType = item
            } while (false)
            
            //最后交易日
            repeat {
                let strText = pkt.d[EnumFieldID.FID_LastTradeDay.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.lastTradeDay = item
            } while (false)
            
            //FID_ShortName
            repeat {
                let strText = pkt.d[EnumFieldID.FID_ShortName.rawValue]
                if strText == nil { break }
                let item = QuoteFieldItem.init(text: strText as! String)
                quoteItem?.shortName = item
            } while (false)
            self.postDelegate.postNotification(withType: .UPDATE_QUOTE, object: nil)
        }
    }
}
