//
//  ChartUpdate.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"


@interface ChartUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *symbolID; //商品代码
@property (nonatomic, assign) NSInteger ctype;  //数据类型 1分时 2 K线
@property (nonatomic, assign) NSInteger count; //数量
@property (nonatomic, strong) NSString *freq; //频率
@property (nonatomic, strong) NSString *period; // Period種類
//資料序號。當資料超過1440 筆時，會提供資料序號以供Client判斷是否為同一次的ChartUpdate。
@property (nonatomic, assign) NSInteger sn;
//資料總筆數。當超過1440筆資料時，會拆分成多個packet傳送，此時會告知Client資料總共有幾筆，可用來判斷是否已收到所有資料
@property (nonatomic, assign) NSInteger total;
// ChartUpdateLineData or ChartUpdateKData
@property (nonatomic, strong) NSArray *d;
// 代表這個Chart所要繪製的盤別區間(HH:MM:SS-HH:MM:SS,HH:MM:SS-HH:MM:SS)
@property (nonatomic, strong) NSString *session;

//此欄提供Chart圖的基準線(參考價), 建議，若沒有提供值時，請使用QuoteUpdate的PreClose
@property (nonatomic, strong) NSNumber *base;
@end
