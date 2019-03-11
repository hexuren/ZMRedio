//
//  APPSessionManager.h
//  lantu
//
//  Created by Eric Wang on 15/7/5.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "REMHTTPSessionManager.h"

@interface APPSessionManager : REMHTTPSessionManager

+ (instancetype)sharedManager;

- (void)setTicket:(NSString *)ticket;
- (void)clearTicket;

@end
