//
//  APPRequest+FMList.m
//  KdFM
//
//  Created by hexuren on 17/6/20.
//  Copyright © 2017年 hexuren. All rights reserved.
//

#import "APPRequest+FMList.h"
#import "ContentCategoryModel.h"
#import "DestinationModel.h"


#define kURLPath @"http://mobile.ximalaya.com/mobile/discovery/v2/category/recommends"
#define kURLCategoryPath @"http://mobile.ximalaya.com/mobile/discovery/v2/category/recommends"
#define kURLAlbumPath @"http://mobile.ximalaya.com/mobile/discovery/v1/category/album"
// 小编推荐栏 更多跳转URL
#define KURLEditor @"http://mobile.ximalaya.com/mobile/discovery/v1/recommend/editor"
// 精品听单栏 更多跳转URL
#define KURLSpecial @"http://mobile.ximalaya.com/m/subject_list"

#define kURLVersion @"version":@"4.3.26.2"
#define kURLDevice @"device":@"ios"
#define KURLScale @"scale":@2
#define kURLCalcDimension @"calcDimension":@"hot"
#define kURLPageID @"pageId":@1
#define kURLStatus  @"status":@0
#define KURLPer_page @"per_page":@10
#define kURLPosition @"position":@1
// 汉字UTF8进行转换并转入字典
#define kURLMoreTitle @"title":[@"更多" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]


@implementation APPRequest (FMList)


+ (id)getCategoryListWithtagName:(NSString *)tagName
                    successBlock:(CommonSuccessResponse)success
                      errorBlock:(CommonErrorResponse)error{
    NSDictionary *params = @{@"categoryId":@(17),
                             @"pageSize":@(50),
                             @"tagName":tagName,
                             kURLPageID,
                             kURLDevice,
                             kURLStatus,
                             kURLCalcDimension};
    return [APPRequest GET:kURLAlbumPath
                parameters:params
                modelClass:[ContentCategoryModel class]
                   keyPath:nil
                   success:success
                   failure:error];
    
}

+ (NSURLSessionDataTask *)getTracksForAlbumId:(NSInteger )albumId
                                    mainTitle:(NSString *)title
                                        idAsc:(BOOL )asc
                                 successBlock:(CommonSuccessResponse)success
                                   errorBlock:(CommonErrorResponse)error{
    NSDictionary *params = @{@"albumId":@(albumId),@"title":title,@"isAsc":@(asc), kURLDevice,kURLPosition};
    NSString *path = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/album/track/%ld/true/1/20",(long)albumId];
    return [APPRequest GET:path
                parameters:params
                modelClass:[DestinationModel class]
                   keyPath:nil
                   success:success
                   failure:error];
}

@end
