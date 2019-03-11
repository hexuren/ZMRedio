//
//  ContentCategoryModel.m
//  喜马拉雅FM(高仿品)
//
//  Created by apple-jd33 on 15/11/19.
//  Copyright © 2015年 HansRove. All rights reserved.
//

#import "ContentCategoryModel.h"

@implementation CategoryListModel

+ (NSValueTransformer *)ntadjunctJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[CategoryListModel class]];
}

@end

@implementation ContentCategoryModel

@end


