//
//  FailureResponseModel.m
//  lantu
//
//  Created by Eric Wang on 15/7/9.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "FailureResponseModel.h"

@implementation FailureResponseModel

- (id)initWithErrorCode:(NSInteger)errorCode errorMessage:(NSString *)message{
    self = [super init];
    if (self) {
        self.errorCode = errorCode;
        self.errorMessage = message;
    }
    return self;
}

@end
