//
//  APPRequest+FMList.h
//  KdFM
//
//  Created by hexuren on 17/6/20.
//  Copyright © 2017年 hexuren. All rights reserved.
//

#import "APPRequest.h"

@interface APPRequest (FMList)


/**
 *  获取电台列表
 *
 *  @param tagName //综合台、文艺台、音乐台、新闻台、故事台
 *  @param success 成功信息
 *  @param error   错误信息
 *
 *  @return
 */

+ (id)getCategoryListWithtagName:(NSString *)tagName
                    successBlock:(CommonSuccessResponse)success
                      errorBlock:(CommonErrorResponse)error;

/**
 *  
 *
 *  @param albumId
 *  @param title
 *  @param success     成功
 *  @param error       错误信息
 *
 *  @return
 */
+ (NSURLSessionDataTask *)getTracksForAlbumId:(NSInteger )albumId
                                    mainTitle:(NSString *)title
                                        idAsc:(BOOL )asc
                                 successBlock:(CommonSuccessResponse)success
                                   errorBlock:(CommonErrorResponse)error;

@end
