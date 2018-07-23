//
//  WmRandomValueBaseItem.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/7/14.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "WmRandomValueBaseItem.h"
#import <objc/runtime.h>
#import "ObserverID.h"
#define ARC4RANDOM_MAX      0x100000000
@implementation WmRandomValueBaseItem
{
    ObserverOption _observerType;
}
/*
 
 ...
 
 */

+ (short) randomShort{
    return arc4random();
}
+ (NSInteger) randomNSInteger{
    return arc4random();
}
+ (long) randomLong{
    return arc4random();
}
+ (int) randomInt{
    return arc4random();
}
+ (NSDecimalNumber *) randomNSDecimalNumber{
    double val = ((double)arc4random() / ARC4RANDOM_MAX);
    return [[NSDecimalNumber alloc] initWithDouble:val];
}
+ (NSNumber *) randomNSNumber{
    double val = ((double)arc4random() / ARC4RANDOM_MAX);
    return [NSNumber numberWithInt:val];
}


+(NSString *) randomStringWithLength: (int) len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    uint32_t length = (uint32_t)[letters length];
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform(length)]];
    }
    return randomString;
}

+ (NSString *) randomNSString{
    return [WmRandomValueBaseItem randomStringWithLength:arc4random_uniform(10)];
}
-(instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}
-(NSDictionary *) generateAllPropertyWithRandomValue:(id)object{
    NSDictionary *dictionary = [WmRandomValueBaseItem propertiesOfObject:self];
    
    NSMutableArray *allPropertyName = [NSMutableArray arrayWithArray:dictionary.allKeys];

    /**
     *  針對指定的property 設定value
     */
    if (object != nil) {
        for (id specificProperty in [object allKeys]) {
            id sepcificValue = [object valueForKey:specificProperty];
            [self setValue:sepcificValue forKey:specificProperty];
        }
        NSArray *sepcificPropertyName = [object allKeys];
        [allPropertyName removeObjectsInArray:sepcificPropertyName];
    }

    
    /**
     *  處理所有(或剩餘)的property
     */
    for (NSString *propertyName in allPropertyName) {
        
        NSString *propertyType = dictionary[propertyName];
        id random = nil;
        if ([propertyType isEqualToString:@"NSString"]) {
            random = [WmRandomValueBaseItem randomNSString];
        }
        else if ([propertyType isEqualToString:@"NSNumber"]) {
            random = [WmRandomValueBaseItem randomNSNumber];
        }
        else if ([propertyType isEqualToString:@"NSDecimalNumber"]) {
            random = [WmRandomValueBaseItem randomNSDecimalNumber];
        }
        else if ([propertyType isEqualToString:@"int"]) {
            random = [WmRandomValueBaseItem randomNSNumber];
        }
        else if ([propertyType isEqualToString:@"NSInteger"]) {
            random = [WmRandomValueBaseItem randomNSNumber];
        }
        else if ([propertyType isEqualToString:@"short"]) {
            random = [WmRandomValueBaseItem randomNSNumber];
        }
        else if ([propertyType isEqualToString:@"long"]) {
            random = [WmRandomValueBaseItem randomNSNumber];
        }
        else if ([propertyType isEqualToString:@"NSMutableDictionary"]) {
            random = [self getNSMutableDictionary];
        }
        else if ([propertyType isEqualToString:@"NSMutableArray"]) {
            random = [self getNSMutableArray];
        }
        else if ([propertyType isEqualToString:@"NSDictionary"]) {
            random = [self getNSMutableDictionary];
        }
        else if ([propertyType isEqualToString:@"NSArray"]) {
            random = [self getNSMutableArray];
        }
        else {
//            NSLog(@"無解析 %@ %@",propertyName,propertyType);
        }
        if (random != nil) {
            [self setValue:random forKey:propertyName];
        }
    }
    return dictionary;
}
-(NSDictionary *) generateAllPropertyWithRandomValue {
    return [self generateAllPropertyWithRandomValue:nil];
}

- (id) getNSMutableDictionary{
    return [NSMutableDictionary new];
}

- (id) getNSMutableArray{
    return [NSMutableArray new];
}

+ (NSDictionary *) propertiesOfObject:(id)object
{
    Class class = [object class];
    return [self propertiesOfClass:class];
}

+ (NSDictionary *) propertiesOfClass:(Class)class
{
    NSMutableDictionary * properties = [NSMutableDictionary dictionary];
    [self propertiesForHierarchyOfClass:class onDictionary:properties];
    return [NSDictionary dictionaryWithDictionary:properties];
}

+ (NSDictionary *) propertiesOfSubclass:(Class)class
{
    if (class == NULL) {
        return nil;
    }
    
    NSMutableDictionary *properties = [NSMutableDictionary dictionary];
    return [self propertiesForSubclass:class onDictionary:properties];
}

+ (NSMutableDictionary *)propertiesForHierarchyOfClass:(Class)class onDictionary:(NSMutableDictionary *)properties
{
    if (class == NULL) {
        return nil;
    }
    
    if (class == [NSObject class]) {
        // On reaching the NSObject base class, return all properties collected.
        return properties;
    }
    
    // Collect properties from the current class.
    [self propertiesForSubclass:class onDictionary:properties];
    
    // Collect properties from the superclass.
    return [self propertiesForHierarchyOfClass:[class superclass] onDictionary:properties];
}

+ (NSMutableDictionary *) propertiesForSubclass:(Class)class onDictionary:(NSMutableDictionary *)properties
{
    unsigned int outCount, i;
    objc_property_t *objcProperties = class_copyPropertyList(class, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = objcProperties[i];
        const char *propName = property_getName(property);
        if(propName) {
            const char *propType = getPropertyType(property);
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSString *propertyType = [NSString stringWithUTF8String:propType];
            [properties setObject:propertyType forKey:propertyName];
        }
    }
    free(objcProperties);
    
    return properties;
}

static const char *getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    unsigned int count;
    
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // A C primitive type:
            /*
             For example, int "i", long "l", unsigned "I", struct.
             Apple docs list plenty of examples of values returned. For a list
             of what will be returned for these primitives, search online for
             "Objective-c" "Property Attribute Description Examples"
             */
            NSString * typeString = [NSString stringWithUTF8String:attributes];
            NSArray * attributes = [typeString componentsSeparatedByString:@","];
            NSString * typeAttribute = [attributes objectAtIndex:0];
            NSString * propertyType = [typeAttribute substringFromIndex:1];
            const char * rawPropertyType = [propertyType UTF8String];
            
            if (strcmp(rawPropertyType, @encode(float)) == 0) {
                //it's a float
            } else if (strcmp(rawPropertyType, @encode(int)) == 0) {
                //it's an int
            } else if (strcmp(rawPropertyType, @encode(id)) == 0) {
                //it's some sort of object
            } else if (strcmp(rawPropertyType, @encode(NSInteger)) == 0) {
                return (const char *)[@"NSInteger" cStringUsingEncoding:NSASCIIStringEncoding];
            } else {
                NSLog(@"");
            }
            
            
            NSString *name = [[NSString alloc] initWithBytes:attribute + 1 length:strlen(attribute) - 1 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // An Objective C id type:
            return "id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            // Another Objective C id type:
            NSString *name = [[NSString alloc] initWithBytes:attribute + 3 length:strlen(attribute) - 4 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
    }
    return "";
}

//- (void) fireNotification:(ObserverOption)type timeInterval:(NSTimeInterval)timeInterval{
//    _observerType = type;
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(postObject) userInfo:nil repeats:true];
//    [timer fire];
//}
- (void) postObject:(ObserverOption)type{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"%d",type] object:self];
    });
}
@end
