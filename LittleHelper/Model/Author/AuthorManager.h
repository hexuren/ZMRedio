//
//  AuthorManager.h
//  lantu
//
//  Created by Eric Wang on 15/8/16.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "LoginResModel.h"

@interface AuthorManager : NSObject

/**
 *  当前是否为登录状态
 *
 *  @return 登录状态
 */
+ (BOOL)isLogin;

/**
 *  获取 ticket 完整字符串
 *
 *  @return ticket 完整字符串
 */
+ (NSString *)ticket;

/**
 *  机构ID
 *
 *  @return orgID
 */
+ (NSString *)orgID;

/**
 *  设置当前登录信息
 *
 *  @param loginRes LoginResModel
 */
+ (void)setLoginInfo:(LoginResModel *)loginRes;

/**
 *  获取当前登录信息
 *
 *  @return LoginResModel
 */
+ (LoginResModel *)loginInfo;

/**
 *  清除用户信息
 */
+ (void)clearLoginUserInfo;

/**
 *  设置当前登录的用户信息
 *
 *  @param user 用户信息
 */
+ (void)setCurrentLoginUser:(UserModel *)user;

/**
 *  返回当前登录的用户信息
 *
 *  @return UserModel
 */
+ (UserModel *)currentLoginUser;

/**
 *  修改当前用户信息
 *
 *  @param user 用户信息
 */
+ (void)saveUser:(UserModel *)user;


+ (void)postLoginStatusInvalidNotification;

+ (void)addLoginStatusInvalidNotificationUsingBlock:(void (^)(NSNotification *note))block;

+ (void)removeLoginStatusInvalidObserver:(id)observer;

+ (NSTimeInterval)timeIntervalFromLastLogin;

+ (void)saveLoginDate;

@end
