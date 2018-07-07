//
//  UnionTokenUpdate.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/1/27.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "TokenUpdate.h"



@interface UnionToken : NSObject
/*
 市場別
 Global: FX, FT (只有臺灣 user 會給 FT)
 China: FX, FC, SC
 
 使用 FX 當作調用 social token
 */
@property (nonatomic, strong,nullable) NSString *market;

/*
 向各市場 AppServer 登入的 union token，一樣是15分鐘到期
 */
@property (nonatomic, strong,nullable) NSString *token;

/*
 user 在此市場的階級，可能值為：
 SIM
 INC
 LIVE
 */
@property (nonatomic, strong, nullable) NSString *level;

/*
 user 在此市場與階級，該登入的 AppServer IP
 */
@property (nonatomic, strong, nullable) NSString *asip;

/*
 user 在此市場與階級，該登入的 AppServer Port
 */
@property (nonatomic, strong, nullable) NSString *asport;

/**
 *  各帳戶默認下單金額
 */
@property (nonatomic, strong, nullable) NSString *defqty;


@end



/* ================================================= */

@interface UnionTokenUpdate : TokenUpdate

@property (nonatomic, strong,nullable) NSArray *tokens;

@property (nonatomic) BOOL isNewUser;

@property (nonatomic, strong ,nullable) NSString *fdtid;

@end
