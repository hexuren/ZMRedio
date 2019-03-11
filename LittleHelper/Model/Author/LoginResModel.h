//
//  LoginResModel.h
//  wutuobang
//
//  Created by Eric Wang on 16/3/11.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "BaseModel.h"
#import "AutoCoding.h"
#import "UserModel.h"

@class companyModel;
@interface LoginResModel : BaseModel

@property (nonatomic, copy) NSString *ticket;

@property (nonatomic, strong) UserModel *user;

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, copy) NSString *force_login;

@property (nonatomic, strong) companyModel *company;

@end

