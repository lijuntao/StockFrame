//
//  WmJsonUpdate.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/7/18.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface WmJsonUpdate : JPacketReceiveBase

/**
 *  參數 JSON
 */
@property (nonatomic,strong) NSString *param_json;
/**
 *  JSON 資料
 */
@property (nonatomic,strong) NSString *json;

@end
