//
//  APPSessionManager.m
//  lantu
//
//  Created by Eric Wang on 15/7/5.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "APPSessionManager.h"
#import "REMResponseSerializer.h"
#import "Config.h"

@implementation APPSessionManager

+ (instancetype)sharedManager{
    static id _sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:APPHostURL];
        _sharedManager = [[self alloc] initWithBaseURL:baseURL];
        [_sharedManager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]];
        AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];

        [_sharedManager setRequestSerializer:requestSerializer];
    });
    return _sharedManager;
}

- (void)setTicket:(NSString *)ticket{
    [self.requestSerializer setValue:ticket forHTTPHeaderField:@"ticket"];
}

- (void)clearTicket{
    [self.requestSerializer setValue:nil forHTTPHeaderField:@"ticket"];
}

@end
