//
//  BaseModel.h
//  zfbuser
//
//  Created by Eric Wang on 15/7/5.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

/**
 *  所有的Model类都继续于些类,
 *  只有当类定义的property与接口返回的字段名称不统一时,需要重新实现+ (NSDictionary *)JSONKeyPathsByPropertyKey
 *  返回字典举例@{@"property":"接口字段名称"}
 */
#import <Mantle/Mantle.h>

@interface BaseModel : MTLModel<MTLJSONSerializing>

@end
