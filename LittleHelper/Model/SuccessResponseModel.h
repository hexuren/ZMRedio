//
//  SuccessResponseModel.h
//  lantu
//
//  Created by Eric Wang on 15/7/9.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "BaseModel.h"

/**
 *  错误代码
 */
typedef NS_ENUM(NSInteger, ErrorCodeType){
    /**
     *  成功
     */
    ErrorCodeTypeSuccess = 200,
    /**
     *  登录已经失效
     */
    ErrorCodeTypeLoginInvalid = 400,
};

@interface SuccessResponseModel : BaseModel

@property (assign, nonatomic) ErrorCodeType errorCode;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) id data;

@end
