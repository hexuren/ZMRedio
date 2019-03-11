//
//  config.h
//  ElectricityPatrolSystem
//
//  Created by apple on 16/5/10.
//  Copyright © 2016年 KevinWu. All rights reserved.
//

#ifndef config_h
#define config_h

#if defined(PARENT_APP)
#define IsParent_APP YES
#define AppSite @"parent"
#else
#define IsParent_APP NO
#define AppSite @"org"
#endif

#ifdef DEBUG
//static const DDLogLevel ddLogLevel = DDLogLevelVerbose;

//开发环境地址
//#define APPHostURL @"http://182.254.230.197:28080/wutuopon"
////发布环境地址
//#define APPHostURL @"http://www.ntongiot.com:8080/api/v1"
#define APPHostURL @""
#else
//static const DDLogLevel ddLogLevel = DDLogLevelOff;
//开发环境地址
//#define APPHostURL @"http://182.254.230.197:28080/wutuopon"
////发布环境地址
#define APPHostURL @"http://www.ntongiot.com:8080/api/v1"

#endif


#define APIVersion @"1.1.0"


//没网时存储的巡检任务的key
#define PLISTDATAKEY @"downLoadSyncData"
//没网时添加图片的key
#define IMAGEDATAKEY @"downLoadSyncImageData"

#define DefineWeakSelf __weak __typeof(self) weakSelf = self

#define APPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

//我的界面宽度
#define MINE_VC_WIDTH 300


//沙盒中Preferences文件夹的路径
#define PREFERENCES_PATH [NSString stringWithFormat:@"%@/Preferences",NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0]]

#endif /* config_h */
