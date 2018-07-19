//
//  WmRandomValueBaseItem.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/7/14.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObserverID.h"
#import "JPacketDef.h"
@interface WmRandomValueBaseItem : NSObject

@property (nonatomic) id wmTag;

/**
 *  自動產生property所有值
 */
-(NSDictionary *) generateAllPropertyWithRandomValue;
/**
 *  自動產生property所有值，並指定某些key value
 *
 *  @param object @{指定的property:指定的數值}
 *
 *  @return <#return value description#>
 */
-(NSDictionary *) generateAllPropertyWithRandomValue:(id)object;
/**
 *  測試用
 *
 *  @return <#return value description#>
 */
- (id) getNSMutableDictionary;
- (id) getNSMutableArray;
- (void) postObject:(ObserverOption)type;
@end
