//
//  UserMappingUpdate.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

typedef enum {
    
    EnumAccountExist_New = 0,
    EnumAccountExist_BindingDone = 1,
    EnumAccountExist_Binding = 2,
    EnumAccountExist_Old = 3,
    
} EnumAccountExist;

@interface UserMappingUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *txid;
@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *user_3rd;
@property (nonatomic, assign) EnumAccountExist exist_3rd;
@property (nonatomic, assign) BOOL exist_user;
@property (nonatomic, strong) NSString *market;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *email;

@end
