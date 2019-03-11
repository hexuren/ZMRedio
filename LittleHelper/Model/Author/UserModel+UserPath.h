//
//  UserModel+UserPath.h
//  zfbuser
//
//  Created by sansan on 15/7/17.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "UserModel.h"

@interface UserModel (UserPath)

//创建根目录（针对当前登录用户）
+(void)createRootDirectoryIfNeed;

//当前用户文件夹
+(NSString *)userRootDocDir;

/**
 *  生成 在用户跟目录下的文件路径信息
 *
 *  @param relativePath 相对路径 eg: test.plist or game/test.plist
 *
 *  @return 绝对路径
 */
+(NSString *)userResPath:(NSString *)relativePath;

@end
