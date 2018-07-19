//
//  WmGroupRankingItem.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/7/4.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "WmQuoteGroupRankingItem.h"
#import "WmQuoteAndRankUpdate.h"
#import "FDTValueFormatter.h"

@implementation WmGroupCategoryBaseItem
- (instancetype)init
{
    self = [super init];
    if (self) {
        _isEmpty = true;
    }
    return self;
}

-(void) fillData:(WmCategoryDataCore *)dataCore withLanguage:(NSString *)language
{
    self.isEmpty = false;
    self.Id = dataCore.sym;
    self.stale = dataCore.sym_stale;
    
    if ([language.uppercaseString isEqualToString:@"TW"]) {
        self.name = dataCore.sym_tw;
    }
    else if ([language.uppercaseString isEqualToString:@"EN"]) {
        self.name = dataCore.sym_en;
    }
    else{
        self.name = dataCore.sym_cn;
    }
}

@end

@implementation WmGroupCategorySymbolItem

-(void) fillData:(WmCategoryDataCore *)dataCore withLanguage:(NSString *)language
{
    [super fillData:dataCore withLanguage:language];
    
    self.price = dataCore.sym_price;
    self.formatPrice = dataCore.sym_price_str;
    self.chgpct = dataCore.sym_ratio;
}

@end

@implementation WmGroupCategoryAmountItem

-(void) fillData:(WmCategoryDataCore *)dataCore withLanguage:(NSString *)language
{
    [super fillData:dataCore withLanguage:language];
    
    self.price = dataCore.sym_price;
    self.formatPrice = dataCore.sym_price_str;
    self.amount = dataCore.amount;
    self.sym_ratio = dataCore.sym_ratio;
}

@end


/**
 * AH股
 */
@implementation WmGroupCategoryAHStockItem

-(void) fillData:(WmCategoryDataCore *)dataCore withLanguage:(NSString *)language
{
    [super fillData:dataCore withLanguage:language];
    
    self.sym_price = dataCore.sym_price;
    self.sym_price_str = dataCore.sym_price_str;
    self.sym_ratio = dataCore.sym_ratio;
    self.sym_hk_con = dataCore.sym_hk_con;
    self.sym_turnover = dataCore.sym_turnover;
    self.sym_ashares = dataCore.sym_ashares;
    self.sym_aratio = dataCore.sym_aratio;
    self.sym_premium = dataCore.sym_premium;
    self.sym_aprice = dataCore.sym_aprice;
}

@end

@interface WmGroupCategoryForexItem ()
{
    int numberOfDecimalPlaces;
}

@property (nonatomic, strong, readwrite) NSString *formatChg;
@end

@implementation WmGroupCategoryForexItem

-(void) fillData:(WmCategoryDataCore *)dataCore withLanguage:(NSString *)language
{
    [super fillData:dataCore withLanguage:language];
    
    self.price = dataCore.sym_price;
    self.formatPrice = dataCore.sym_price_str;
    self.chg = dataCore.sym_chg;
}

-(void) setFormatPrice:(NSString *)formatPrice
{
    _formatPrice = formatPrice;
    
    NSArray *floatStringComps = [formatPrice componentsSeparatedByString:@"."];
    numberOfDecimalPlaces = (int)[[floatStringComps objectAtIndex:1] length];
}

-(void) setChg:(NSDecimalNumber *)chg
{
    _chg = chg;
    _formatChg = [FDTValueFormatter formatToWMFXStyle:chg withDeciamlDigit:numberOfDecimalPlaces];
}

@end

/**
 * 换手率
 */
@implementation WmGroupCategoryTurnoverItem

-(void) fillData:(WmCategoryDataCore *)dataCore withLanguage:(NSString *)language
{
    [super fillData:dataCore withLanguage:language];
    
    self.sym_price = dataCore.sym_price;
    self.sym_turnover = dataCore.sym_turnover;
    self.sym_ratio = dataCore.sym_ratio;
}

@end

@implementation WmGroupCategoryIndustryItem

+(instancetype) fillData:(WmCategoryDataCore *)dataCore withLanguage:(NSString *)language
{
    WmGroupCategorySymbolItem *leadSymbol = [WmGroupCategorySymbolItem new];
    [leadSymbol fillData:dataCore withLanguage:language];
    
    WmGroupCategoryIndustryItem *symbolItem = [WmGroupCategoryIndustryItem new];
    symbolItem.isEmpty = false;
    symbolItem.Id = dataCore.industry;
    symbolItem.chgpct = dataCore.sym_ratio;
    symbolItem.stale = dataCore.sym_stale;
    symbolItem.leadSymbol = leadSymbol;
    
    if ([language.uppercaseString isEqualToString:@"TW"]) {
        symbolItem.name = dataCore.industry_tw;
    }
    else if ([language.uppercaseString isEqualToString:@"EN"]) {
        symbolItem.name = dataCore.industry_en;
    }
    else{
        symbolItem.name = dataCore.industry_cn;
    }
    
    return symbolItem;
}

/**
 *  override 測試用
 *
 *  @return 所有property
 */
-(NSDictionary *) generateAllPropertyWithRandomValue{
    NSDictionary *dictionary = [super generateAllPropertyWithRandomValue];
    WmGroupCategorySymbolItem *item = [WmGroupCategorySymbolItem new];
    [item generateAllPropertyWithRandomValue];
    self.leadSymbol = item;
    return dictionary;
}
@end

@implementation WmQuoteCategory
-(instancetype)init{
    self = [super init];
    if (self) {
        _data = [NSMutableArray new];
    }
    return self;
}
- (void) addCategoryOrSymbol:(WmGroupCategoryBaseItem *)item{
    
    if (_data == nil) {
        _data = [NSMutableArray new];
    }

    [_data addObject:item];
}

/**
 *  override 測試用
 *
 *  @return 所有property
 */
-(id)getNSMutableArray{
    NSMutableArray *array = [NSMutableArray new];
    
    if ([self.categoryId isEqualToString:@"INDUSTRY"]) {
        
        short count = self.level == 0 ? 6 : 20;
        
        for (int i = 0; i <count; i++) {
            WmGroupCategoryIndustryItem *object1 = [WmGroupCategoryIndustryItem new];
            [object1 generateAllPropertyWithRandomValue];
            [array addObject:object1];
        }
    }
    else if ([self.categoryId isEqualToString:@"MAINUP"] ||
             [self.categoryId isEqualToString:@"MAINDOWN"] ||
             [self.categoryId isEqualToString:@"MAINAMT"]){
        
        short count = self.level == 0 ? 10 : 40;
        
        for (int i = 0; i <count; i++) {
            WmGroupCategorySymbolItem *object1 = [WmGroupCategorySymbolItem new];
            [object1 generateAllPropertyWithRandomValue];
            [array addObject:object1];
        }
    }
    return array;
}
@end

@implementation WmQuoteGroupRankingItem
{
    NSMutableDictionary *itemDictionary;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        _dataDictionary = [NSMutableDictionary new];
        itemDictionary = [NSMutableDictionary new];
    }
    return self;
}

-(void) addIndustryOrSymbol:(WmGroupCategoryBaseItem *)item category:(NSString *)categoryId level:(NSInteger)level{
    
    if (categoryId == nil) {
        return;
    }
    
    WmQuoteCategory *categoryItem = [_dataDictionary objectForKey:categoryId];
    if (categoryItem == nil) {
        categoryItem = [WmQuoteCategory new];
        categoryItem.categoryId = categoryId;
        categoryItem.level = level;
        [_dataDictionary setObject:categoryItem forKey:categoryId];
    }
    if (item.isEmpty == true) {
        return;
    }
    [categoryItem addCategoryOrSymbol:item];
}

- (NSArray<WmGroupCategoryBaseItem *> *) getDataWithCategoryId:(NSString *)categoryId{
    if (categoryId == nil) {
        return nil;
    }
    WmQuoteCategory *categoryItem = [_dataDictionary objectForKey:categoryId];
    
    return categoryItem.data;
}

- (NSArray<NSString *> *) getCategoryList{
    return _dataDictionary.allKeys;
}


/**
 *  override 測試用
 *
 *  @return 所有property
 */
- (id) getNSMutableDictionary{
    NSDictionary *wmTagDictionary = (NSDictionary *)self.wmTag;
    NSMutableDictionary * specificValue1 = [NSMutableDictionary dictionaryWithDictionary:wmTagDictionary];
    NSMutableDictionary * specificValue2 = [NSMutableDictionary dictionaryWithDictionary:wmTagDictionary];
    NSMutableDictionary * specificValue3 = [NSMutableDictionary dictionaryWithDictionary:wmTagDictionary];
    NSMutableDictionary * specificValue4 =  [NSMutableDictionary dictionaryWithDictionary:wmTagDictionary];
    [specificValue1 setDictionary:@{@"categoryId":@"INDUSTRY"}];
    [specificValue2 setDictionary:@{@"categoryId":@"MAINUP"}];
    [specificValue3 setDictionary:@{@"categoryId":@"MAINDOWN"}];
    [specificValue4 setDictionary:@{@"categoryId":@"MAINAMT"}];
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    WmQuoteCategory *object1 = [WmQuoteCategory new];
    [object1 generateAllPropertyWithRandomValue:specificValue1];
    [dictionary setValue:object1 forKey:@"INDUSTRY"];
    WmQuoteCategory *object2 = [WmQuoteCategory new];
    [object2 generateAllPropertyWithRandomValue:specificValue2];
    [dictionary setValue:object2 forKey:@"MAINUP"];
    WmQuoteCategory *object3 = [WmQuoteCategory new];
    [object3 generateAllPropertyWithRandomValue:specificValue3];
    [dictionary setValue:object3 forKey:@"MAINDOWN"];
    WmQuoteCategory *object4 = [WmQuoteCategory new];
    [object4 generateAllPropertyWithRandomValue:specificValue4];
    [dictionary setValue:object4 forKey:@"MAINAMT"];
    return dictionary;
}
@end
