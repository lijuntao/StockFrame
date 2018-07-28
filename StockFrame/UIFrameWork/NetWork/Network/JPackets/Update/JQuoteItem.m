//
//  JQuoteItem.m
//  MasterDataManager
//
//  Created by Rick on 2014/5/19.
//  Copyright (c) 2014年 FDT. All rights reserved.
//

#import "JQuoteItem.h"
#import "QuoteFieldItem.h"

@implementation JQuoteItem

- (id)init
{
    self = [super init];
    if (self)
    {
        _symbolID = nil;
        
        _stale = EnumQuoteStale_None;
        _status = EnumQuoteStatus_Normal;
        _totalVolume = [QuoteFieldItem new];
        _price = [QuoteFieldItem new];
        _priceChange = [QuoteFieldItem new];
        _priceorPreClose = [QuoteFieldItem new];
        _priceChangeRatio = [QuoteFieldItem new];
        _EN_Name = [QuoteFieldItem new];
        _CN_Name = [QuoteFieldItem new];
        _TW_Name = [QuoteFieldItem new];
        _shortName = [QuoteFieldItem new];
        _tradingDate = [QuoteFieldItem new];
        _bid = [QuoteFieldItem new];
        _ask = [QuoteFieldItem new];
        _preClose = [QuoteFieldItem new];
        _tradingTime = [QuoteFieldItem new];
        _high = [QuoteFieldItem new];
        _low = [QuoteFieldItem new];
        _settlePrice = [QuoteFieldItem new];
        _openInterest = [QuoteFieldItem new];
        _volume = [QuoteFieldItem new];
        _open = [QuoteFieldItem new];
        _upLimit = [QuoteFieldItem new];
        _downLimit = [QuoteFieldItem new];
        _close = [QuoteFieldItem new];
        _high52W = [QuoteFieldItem new];
        _low52W = [QuoteFieldItem new];
        _amount = [QuoteFieldItem new];
        _buyDealVol = [QuoteFieldItem new];
        _sellDealVol = [QuoteFieldItem new];
        
        _sharesOut = [QuoteFieldItem new];
        _neutralDealVol = [QuoteFieldItem new];
        _buyDealAmt = [QuoteFieldItem new];
        _sellDealAmt = [QuoteFieldItem new];
        _neutralDealAmt = [QuoteFieldItem new];
        _totalCapital = [QuoteFieldItem new];
        _netProfitMgn = [QuoteFieldItem new];
        _turnoverRt = [QuoteFieldItem new];
        _valPftRt = [QuoteFieldItem new];
        _totalValue = [QuoteFieldItem new];
        _outValue = [QuoteFieldItem new];
        _amplitude = [QuoteFieldItem new];
        
        _dividendAmount = [QuoteFieldItem new];
        _dividendRate = [QuoteFieldItem new];
        _beta = [QuoteFieldItem new];
        _totalAssets = [QuoteFieldItem new];
        _nav = [QuoteFieldItem new];
        _premiumDiscountRate = [QuoteFieldItem new];
        _ytdReturn = [QuoteFieldItem new];
        _expenseRatio = [QuoteFieldItem new];
        
        _bidPx1 = [QuoteFieldItem new];
        _bidPx2 = [QuoteFieldItem new];
        _bidPx3 = [QuoteFieldItem new];
        _bidPx4 = [QuoteFieldItem new];
        _bidPx5 = [QuoteFieldItem new];
        
        _askPx1 = [QuoteFieldItem new];
        _askPx2 = [QuoteFieldItem new];
        _askPx3 = [QuoteFieldItem new];
        _askPx4 = [QuoteFieldItem new];
        _askPx5 = [QuoteFieldItem new];
        
        _bidSz1 = [QuoteFieldItem new];
        _bidSz2 = [QuoteFieldItem new];
        _bidSz3 = [QuoteFieldItem new];
        _bidSz4 = [QuoteFieldItem new];
        _bidSz5 = [QuoteFieldItem new];
        
        _askSz1 = [QuoteFieldItem new];
        _askSz2 = [QuoteFieldItem new];
        _askSz3 = [QuoteFieldItem new];
        _askSz4 = [QuoteFieldItem new];
        _askSz5 = [QuoteFieldItem new];
        
        _askVolume = [QuoteFieldItem new];
        _bidVolume = [QuoteFieldItem new];
        
        _hasRzrq = [QuoteFieldItem new];
        
        _derivative = [QuoteFieldItem new];
        _underlyingSymbol = [QuoteFieldItem new];
        _leverageRatio = [QuoteFieldItem new];
        _exercisePrice = [QuoteFieldItem new];
        _delta = [QuoteFieldItem new];
        _premium = [QuoteFieldItem new];
        _outstandingQuantityRate = [QuoteFieldItem new];
        _conversionRatio = [QuoteFieldItem new];
        _impliedVolatility = [QuoteFieldItem new];
        _effectiveLever = [QuoteFieldItem new];
        _strikePoint = [QuoteFieldItem new];
        _maturity = [QuoteFieldItem new];
        _recoverableValue = [QuoteFieldItem new];
        _hkType = [QuoteFieldItem new];
        _lastTradeDay = [QuoteFieldItem new];
        
        _supportRealTimeQuote = true;
        
    }
    return self;
}

- (id)initWithSymbolID:(NSString *)strSymbolID
{
    self = [self init];
    _symbolID = strSymbolID;
    if ([strSymbolID containsString:@".HK"]) {
        _supportRealTimeQuote = false;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    JQuoteItem *item = [[[self class] allocWithZone:zone] init];
    if (item)
    {
        [item setSymbolID:[_symbolID copy]];
        
        [item setStale:_stale];
        [item setStatus:_status];
        [item setTotalVolume:[_totalVolume copy]];
        [item setPrice:[_price copy]];
        [item setPriceorPreClose:[_priceorPreClose copy]];
        [item setPriceChange:[_priceChange copy]];
        [item setPriceChangeRatio:[_priceChangeRatio copy]];
        [item setEN_Name:[_EN_Name copy]];
        [item setCN_Name:[_CN_Name copy]];
        [item setTW_Name:[_TW_Name copy]];
        [item setShortName:[_shortName copy]];
        [item setTradingDate:[_tradingDate copy]];
        [item setBid:[_bid copy]];
        [item setAsk:[_ask copy]];
        [item setPreClose:[_preClose copy]];
        [item setTradingTime:[_tradingTime copy]];
        [item setHigh:[_high copy]];
        [item setLow:[_low copy]];
        [item setSettlePrice:[_settlePrice copy]];
        [item setOpenInterest:[_openInterest copy]];
        [item setVolume:[_volume copy]];
        [item setOpen:[_open copy]];
        [item setUpLimit:[_upLimit copy]];
        [item setDownLimit:[_downLimit copy]];
        [item setClose:[_close copy]];
        [item setHigh52W:[_high52W copy]];
        [item setLow52W:[_low52W copy]];
        [item setAmount:[_amount copy]];
        [item setBuyDealVol:[_buyDealVol copy]];
        [item setSellDealVol:[_sellDealVol copy]];
        
        [item setSharesOut:[_sharesOut copy]];
        [item setNeutralDealVol:[_neutralDealVol copy]];
        [item setBuyDealAmt:[_buyDealAmt copy]];
        [item setSellDealAmt:[_sellDealAmt copy]];
        [item setNeutralDealAmt:[_neutralDealAmt copy]];
        [item setTotalCapital:[_totalCapital copy]];
        [item setNetProfitMgn:[_netProfitMgn copy]];
        [item setTurnoverRt:[_turnoverRt copy]];
        [item setValPftRt:[_valPftRt copy]];
        [item setTotalValue:[_totalValue copy]];
        [item setOutValue:[_outValue copy]];
        [item setAmplitude:[_amplitude copy]];
        
        [item setDividendAmount:[_dividendAmount copy]];
        [item setDividendRate:[_dividendRate copy]];
        [item setBeta:[_beta copy]];
        [item setTotalAssets:[_totalAssets copy]];
        [item setNav:[_nav copy]];
        [item setPremiumDiscountRate:[_premiumDiscountRate copy]];
        [item setYtdReturn:[_ytdReturn copy]];
        [item setExpenseRatio:[_expenseRatio copy]];
        
        [item setBidPx1:[_bidPx1 copy]];
        [item setBidPx2:[_bidPx2 copy]];
        [item setBidPx3:[_bidPx3 copy]];
        [item setBidPx4:[_bidPx4 copy]];
        [item setBidPx5:[_bidPx5 copy]];
        
        [item setAskPx1:[_askPx1 copy]];
        [item setAskPx2:[_askPx2 copy]];
        [item setAskPx3:[_askPx3 copy]];
        [item setAskPx4:[_askPx4 copy]];
        [item setAskPx5:[_askPx5 copy]];
        
        [item setBidSz1:[_bidSz1 copy]];
        [item setBidSz2:[_bidSz2 copy]];
        [item setBidSz3:[_bidSz3 copy]];
        [item setBidSz4:[_bidSz4 copy]];
        [item setBidSz5:[_bidSz5 copy]];
        
        [item setAskSz1:[_askSz1 copy]];
        [item setAskSz2:[_askSz2 copy]];
        [item setAskSz3:[_askSz3 copy]];
        [item setAskSz4:[_askSz4 copy]];
        [item setAskSz5:[_askSz5 copy]];
        
        [item setAskVolume:[_askVolume copy]];
        [item setBidVolume:[_bidVolume copy]];
        
        [item setHasRzrq:[_hasRzrq copy]];
        
        [item setDerivative:[_derivative copy]];
        [item setUnderlyingSymbol:[_underlyingSymbol copy]];
        [item setLeverageRatio:[_leverageRatio copy]];
        [item setExercisePrice:[_exercisePrice copy]];
        [item setDelta:[_delta copy]];
        [item setPremium:[_premium copy]];
        [item setOutstandingQuantityRate:[_outstandingQuantityRate copy]];
        [item setConversionRatio:[_conversionRatio copy]];
        [item setImpliedVolatility:[_impliedVolatility copy]];
        [item setEffectiveLever:[_effectiveLever copy]];
        [item setStrikePoint:[_strikePoint copy]];
        [item setMaturity:[_maturity copy]];
        [item setRecoverableValue:[_recoverableValue copy]];
        [item setHkType:[_hkType copy]];
        [item setLastTradeDay:[_lastTradeDay copy]];
        
    }
    
    return item;
}
-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.symbolID forKey:@"symbolID"];
    [encoder encodeInt:self.stale forKey:@"stale"];
    [encoder encodeInt:self.status forKey:@"status"];
    [encoder encodeObject:self.tradingDate forKey:@"tradingDate"];
    [encoder encodeObject:self.tradingTime forKey:@"tradingTime"];
    [encoder encodeObject:self.volume forKey:@"volume"];
    [encoder encodeObject:self.totalVolume forKey:@"totalVolume"];
    [encoder encodeObject:self.preClose forKey:@"preClose"];
    [encoder encodeObject:self.bid forKey:@"bid"];
    [encoder encodeObject:self.ask forKey:@"ask"];
    [encoder encodeObject:self.price forKey:@"price"];
    [encoder encodeObject:self.priceorPreClose forKey:@"priceorPreClose"];
    [encoder encodeObject:self.priceChange forKey:@"priceChange"];
    [encoder encodeObject:self.priceChangeRatio forKey:@"priceChangeRatio"];
    [encoder encodeObject:self.EN_Name forKey:@"EN_Name"];
    [encoder encodeObject:self.CN_Name forKey:@"CN_Name"];
    [encoder encodeObject:self.TW_Name forKey:@"TW_Name"];
    [encoder encodeObject:self.shortName forKey:@"shortName"];
    [encoder encodeObject:self.open forKey:@"open"];
    [encoder encodeObject:self.high forKey:@"high"];
    [encoder encodeObject:self.low forKey:@"low"];
    [encoder encodeObject:self.close forKey:@"close"];
    [encoder encodeObject:self.high52W forKey:@"high52W"];
    [encoder encodeObject:self.low52W forKey:@"low52W"];
    
    [encoder encodeObject:self.bidVolume forKey:@"bidVolume"];
    [encoder encodeObject:self.askVolume forKey:@"askVolume"];
    
    [encoder encodeObject:self.turnoverRt forKey:@"turnoverRt"];
    [encoder encodeObject:self.totalValue forKey:@"totalValue"];
    
    [encoder encodeObject:self.dividendAmount forKey:@"dividendAmount"];
    [encoder encodeObject:self.dividendRate forKey:@"dividendRate"];
    [encoder encodeObject:self.beta forKey:@"beta"];
    [encoder encodeObject:self.totalAssets forKey:@"totalAssets"];
    [encoder encodeObject:self.nav forKey:@"nav"];
    [encoder encodeObject:self.premiumDiscountRate forKey:@"premiumDiscountRate"];
    [encoder encodeObject:self.ytdReturn forKey:@"ytdReturn"];
    [encoder encodeObject:self.expenseRatio forKey:@"expenseRatio"];
    
    [encoder encodeObject:self.underlyingSymbol forKey:@"hasRzrq"];
    [encoder encodeObject:self.derivative forKey:@"derivative"];
    [encoder encodeObject:self.underlyingSymbol forKey:@"underlyingSymbol"];
    [encoder encodeObject:self.leverageRatio forKey:@"leverageRatio"];
    [encoder encodeObject:self.exercisePrice forKey:@"exercisePrice"];
    [encoder encodeObject:self.delta forKey:@"delta"];
    [encoder encodeObject:self.premium forKey:@"premium"];
    [encoder encodeObject:self.premium forKey:@"outstandingQuantityRate"];
    [encoder encodeObject:self.conversionRatio forKey:@"conversionRatio"];
    [encoder encodeObject:self.impliedVolatility forKey:@"impliedVolatility"];
    [encoder encodeObject:self.effectiveLever forKey:@"effectiveLever"];
    [encoder encodeObject:self.strikePoint forKey:@"strikePoint"];
    [encoder encodeObject:self.maturity forKey:@"maturity"];
    [encoder encodeObject:self.recoverableValue forKey:@"recoverableValue"];
    [encoder encodeObject:self.hkType forKey:@"hkType"];
    [encoder encodeObject:self.lastTradeDay forKey:@"lastTradeDay"];
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.symbolID = [decoder decodeObjectForKey:@"symbolID"];
        self.stale = [decoder decodeIntForKey:@"stale"];
        self.status = [decoder decodeIntForKey:@"status"];
        self.tradingDate = [decoder decodeObjectForKey:@"tradingDate"];
        self.tradingTime = [decoder decodeObjectForKey:@"tradingTime"];
        self.volume = [decoder decodeObjectForKey:@"volume"];
        self.totalVolume = [decoder decodeObjectForKey:@"totalVolume"];
        self.preClose = [decoder decodeObjectForKey:@"preClose"];
        self.bid = [decoder decodeObjectForKey:@"bid"];
        self.ask = [decoder decodeObjectForKey:@"ask"];
        self.price = [decoder decodeObjectForKey:@"price"];
        self.priceorPreClose = [decoder decodeObjectForKey:@"priceorPreClose"];
        self.priceChange = [decoder decodeObjectForKey:@"priceChange"];
        self.priceChangeRatio = [decoder decodeObjectForKey:@"priceChangeRatio"];
        self.EN_Name = [decoder decodeObjectForKey:@"EN_Name"];
        self.CN_Name = [decoder decodeObjectForKey:@"CN_Name"];
        self.TW_Name = [decoder decodeObjectForKey:@"TW_Name"];
        self.shortName = [decoder decodeObjectForKey:@"shortName"];
        self.open = [decoder decodeObjectForKey:@"open"];
        self.high = [decoder decodeObjectForKey:@"high"];
        self.low = [decoder decodeObjectForKey:@"low"];
        self.close = [decoder decodeObjectForKey:@"close"];
        self.high52W = [decoder decodeObjectForKey:@"high52W"];
        self.low52W = [decoder decodeObjectForKey:@"low52W"];
        self.bidVolume = [decoder decodeObjectForKey:@"bidVolume"];
        self.askVolume = [decoder decodeObjectForKey:@"askVolume"];
        
        self.hasRzrq = [decoder decodeObjectForKey:@"hasRzrq"];
        self.turnoverRt = [decoder decodeObjectForKey:@"turnoverRt"];
        self.totalValue = [decoder decodeObjectForKey:@"totalValue"];
        self.derivative = [self protectDecodeWithDecoder:decoder key:@"derivative"];
        self.underlyingSymbol = [self protectDecodeWithDecoder:decoder key:@"underlyingSymbol"];
        self.leverageRatio = [self protectDecodeWithDecoder:decoder key:@"leverageRatio"];
        self.exercisePrice = [self protectDecodeWithDecoder:decoder key:@"exercisePrice"];
        self.delta = [self protectDecodeWithDecoder:decoder key:@"delta"];
        self.premium = [self protectDecodeWithDecoder:decoder key:@"premium"];
        self.outstandingQuantityRate = [self protectDecodeWithDecoder:decoder key:@"outstandingQuantityRate"];
        self.conversionRatio = [self protectDecodeWithDecoder:decoder key:@"conversionRatio"];
        self.impliedVolatility = [self protectDecodeWithDecoder:decoder key:@"impliedVolatility"];
        self.effectiveLever = [self protectDecodeWithDecoder:decoder key:@"effectiveLever"];
        self.strikePoint = [self protectDecodeWithDecoder:decoder key:@"strikePoint"];
        self.maturity = [self protectDecodeWithDecoder:decoder key:@"maturity"];
        self.recoverableValue = [self protectDecodeWithDecoder:decoder key:@"recoverableValue"];
        self.hkType = [self protectDecodeWithDecoder:decoder key:@"hkType"];
        self.lastTradeDay = [self protectDecodeWithDecoder:decoder key:@"lastTradeDay"];
        
        //TODO: 兼容function, 1.3(5) 存了爛爛的data, 這部分可以直接升版且預防crash, 上線前要移除
        self.dividendAmount = [self protectDecodeWithDecoder:decoder key:@"dividendAmount"];
        self.dividendRate = [self protectDecodeWithDecoder:decoder key:@"dividendRate"];
        self.beta = [self protectDecodeWithDecoder:decoder key:@"beta"];
        self.totalAssets = [self protectDecodeWithDecoder:decoder key:@"totalAssets"];
        self.nav = [self protectDecodeWithDecoder:decoder key:@"nav"];
        self.premiumDiscountRate = [self protectDecodeWithDecoder:decoder key:@"premiumDiscountRate"];
        self.ytdReturn = [self protectDecodeWithDecoder:decoder key:@"ytdReturn"];
        self.expenseRatio = [self protectDecodeWithDecoder:decoder key:@"expenseRatio"];
        
        
    }
    return self;
}
-(QuoteFieldItem *) protectDecodeWithDecoder:(NSCoder *)decoder key:(NSString *)key{
    id item = [decoder decodeObjectForKey:@"key"];
    if ([item isKindOfClass:[QuoteFieldItem class]]) {
        return item;
    }
    return [QuoteFieldItem new];
}
@end
