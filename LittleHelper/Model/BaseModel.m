//
//  BaseModel.m
//  zfbuser
//
//  Created by Eric Wang on 15/7/5.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel


/**
 *  类的属性 跟  服务端 json keypath 的映射
 *
 *  @return @{@"属性" :@"jsonKeyPath"}
 */
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSSet * setProperty = (NSSet *)[self propertyKeys];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    for (NSString *propertyKey in setProperty) {
        NSString * jsonKey = [NSString stringWithFormat:@"%@",propertyKey];
        [dict setObject:jsonKey forKey:propertyKey];
    };
    return dict;
}

//- (NSDictionary *)dictionaryValue {
//    NSMutableDictionary *modifiedDictionaryValue = [[super dictionaryValue] mutableCopy];
//    
//    for (NSString *originalKey in [super dictionaryValue]) {
//        if ([self valueForKey:originalKey] == nil) {
//            [modifiedDictionaryValue removeObjectForKey:originalKey];
//        }
//    }
//    
//    return [modifiedDictionaryValue copy];
//}

- (void)setNilValueForKey:(NSString *)key {
    [self setValue:@0 forKey:key];  // For NSInteger/CGFloat/BOOL
}

@end
