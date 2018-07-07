//
//  WmGetJson.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/7/18.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface WmGetJson : JPacketSendBase

- (id)initWithType:(NSString *)param_json;

/**
 *  參數 JSON
 
    "{"id":"ACCOUNT","param":{}}"
 
    id 表示要取得的資料類型，目前提供：
    ACCOUNT － 賬戶各幣別現金與匯率
 */
@property (nonatomic,strong) NSString *param_json;

@end
