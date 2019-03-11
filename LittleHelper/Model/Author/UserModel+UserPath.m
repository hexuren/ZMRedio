//
//  UserModel+UserPath.m
//  zfbuser
//
//  Created by sansan on 15/7/17.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "UserModel+UserPath.h"

@implementation UserModel (UserPath)

+ (void)createRootDirectoryIfNeed{
    NSFileManager * fileMgr = [NSFileManager defaultManager];
    
    BOOL succ = [fileMgr createDirectoryAtPath:[self userRootDocDir] withIntermediateDirectories:YES attributes:nil error:nil];
    if (succ) {
//        NSLog(@"创建用户路径成功：%@",[self userRootDocDir]);
    }else{
        NSLog(@"创建用户路径失败：%@",[self userRootDocDir]);
    };
}

+ (NSString *)userRootDocDir{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];//Documents目录
    
    NSString *documentsDirectory = NSTemporaryDirectory();
    
    NSString *userName = @"guest";
    if ([AuthorManager isLogin]) {
//        UserModel *model = [AuthorManager currentLoginUser];
//        userName = @(model.user_id).stringValue;
    }
    return [documentsDirectory stringByAppendingPathComponent:userName];
}

/**
 *  生成 在用户跟目录下的文件路径信息
 *
 *  @param relativePath 相对路径 eg: test.plist or game/test.plist
 *
 *  @return 绝对路径
 */
+ (NSString *)userResPath:(NSString *)relativePath{
    [self createRootDirectoryIfNeed];
    NSString * path = [[self userRootDocDir] stringByAppendingPathComponent:relativePath];
    return path;
}

@end
