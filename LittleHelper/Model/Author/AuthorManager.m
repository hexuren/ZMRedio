//
//  AuthorManager.m
//  lantu
//
//  Created by Eric Wang on 15/8/16.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "AuthorManager.h"

static NSString *const loginResponseModelKey = @"LoginResponseModelKey";

static NSString *const currentLoginUserKey = @"currentLoginUserKey";

static NSString *const userLoginStatusInvalidKey = @"userLoginStatusInvalidKey";

static NSString *const lastLoginKey = @"lastLoginKey";


@implementation AuthorManager

+ (BOOL)isLogin{
    if ([self ticket]) {
        return YES;
    }
    return NO;
}

+ (NSString *)ticket{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:loginResponseModelKey];
    LoginResModel *loginRes = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return loginRes.ticket;
}

//+ (NSString *)orgID{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSData *encodedObject = [defaults objectForKey:loginResponseModelKey];
//    LoginResModel *loginRes = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
//    return @(loginRes.institution_id).stringValue;
//}

+ (void)setLoginInfo:(LoginResModel *)loginRes{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *loginResEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:loginRes];
    [defaults setValue:loginResEncodedObject forKey:loginResponseModelKey];
    [defaults synchronize];
}

+ (LoginResModel *)loginInfo{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:loginResponseModelKey];
    LoginResModel *loginRes = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return loginRes;
}

+ (void)clearLoginUserInfo{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:nil forKey:loginResponseModelKey];
    [defaults setValue:nil forKey:currentLoginUserKey];
    [defaults synchronize];
}

+ (void)setCurrentLoginUser:(UserModel *)user{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *loginResEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:user];
    [defaults setValue:loginResEncodedObject forKey:currentLoginUserKey];
    [defaults synchronize];
}

+ (UserModel *)currentLoginUser{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:currentLoginUserKey];
    UserModel *user = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return user;
}

+ (void)saveUser:(UserModel *)user{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *loginResEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:user];
    [defaults setValue:loginResEncodedObject forKey:currentLoginUserKey];
    [defaults synchronize];
}

+ (void)postLoginStatusInvalidNotification{
    [[NSNotificationCenter defaultCenter] postNotificationName:userLoginStatusInvalidKey object:nil];
}

+ (void)addLoginStatusInvalidNotificationUsingBlock:(void (^)(NSNotification *note))block{
    [[NSNotificationCenter defaultCenter] addObserverForName:userLoginStatusInvalidKey object:nil queue:nil usingBlock:block];
}

+ (void)removeLoginStatusInvalidObserver:(id)observer{
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:userLoginStatusInvalidKey object:nil];
}


+ (NSTimeInterval)timeIntervalFromLastLogin
{
    NSDate * date = [NSDate date];
    NSDate * lastLoginDate = [[NSUserDefaults standardUserDefaults] objectForKey:lastLoginKey];
    NSTimeInterval betweenTime;
    if (lastLoginDate) {
        betweenTime  = [date timeIntervalSinceDate:lastLoginDate];
    }
    return betweenTime;
}

+ (void)saveLoginDate
{
    NSDate * date = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:lastLoginKey];
    
}
@end
