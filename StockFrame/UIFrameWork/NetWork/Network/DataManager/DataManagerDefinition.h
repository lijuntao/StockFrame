//
//  DataManagerDefinition.h
//  StockFrame
//
//  Created by fdt on 2018/7/19.
//  Copyright © 2018年 ljt. All rights reserved.
//

#ifndef DataManagerDefinition_h
#define DataManagerDefinition_h

#import "ObserverID.h"

@protocol DataManagerPostNotificationDelegate <NSObject>
-(void) postNotificationWithType:(ObserverOption)type object:(nullable id)object;
-(void) postNotificationWithType:(ObserverOption)type object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo;
@end

#endif /* DataManagerDefinition_h */
