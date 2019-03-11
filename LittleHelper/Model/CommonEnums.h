//
//  CommonEnums.h
//  wutuobang
//
//  Created by Eric Wang on 16/4/25.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  巡检任务类型
 */
typedef NS_ENUM(NSUInteger, TaskStatus) {
    /**
     *  新建
     */
    TaskStatusNew = 1,
    /**
     *  巡检中
     */
    TaskStatusUnderWay = 2,
    /**
     *  巡检完成
     */
    TaskStatusComplete = 3,
    /**
     *  审核中
     */
    TaskStatusAuditing = 4,
    /**
     *  审核完成
     */
    TaskStatusAuditComplete = 5,
};



/**
 *  消息类型
 */
typedef NS_ENUM(NSUInteger, MessageType) {
    /**
     *  巡检任务
     */
    powerTask = 0,
    /**
     *  巡检审核
     */
    powerApproval = 1,
    /**
     *  巡检报告
     */
    powerReport = 2,
    /**
     *  合同审批
     */
    contract = 3
};

/**
 *  公告类型
 */
typedef NS_ENUM(NSUInteger, NoticesType) {
    /**
     * 系统公告
     */
    SystemNotice = 1,
    /**
     *  业绩公告
     */
    ResultsNotice = 2,
    /**
     *  假期公告
     */
    HolidayNotice = 3,
    /**
     *  人事公告
     */
    PersonnelNotice = 4,
    /**
     *  其他公告
     */
    OtherNotice = 5,
};



/**
 *  性别
 */
typedef NS_ENUM(NSUInteger, SexType) {
    /**
     *  未定义
     */
    SexTypeUndefine = 0,
    /**
     *  男
     */
    SexTypeMale = 1,
    /**
     *  女
     */
    SexTypeFemale = 2,
};

/**
 *  短信类型
 */
typedef NS_ENUM(NSUInteger, SMSType) {
    /**
     *  注册
     */
    SMSTypeRegister,
    /**
     *  忘记密码
     */
    SMSTypeForgetPassword,
    /**
     *  其他
     */
    SMSTypeOther
};


/**
 *  家长身份
 */
typedef NS_ENUM(NSUInteger, RelationShipType) {
    /**
     *  爸爸
     */
    RelationShipTypeFather = 1,
    /**
     *  妈妈
     */
    RelationShipTypeMother,
    /**
     *  兄弟姐妹
     */
    RelationShipTypeBrotherOrSister,
    /**
     *  爷爷
     */
    RelationShipTypeGrandpa,
    /**
     *  奶奶
     */
    RelationShipTypeGrandma
};



/**
 *  已点名列表
 */
typedef NS_ENUM(NSUInteger, CallTaskSortType) {
    /**
     *  按签到时间排序
     */
    CallTaskSortTypeByTime = 0,
    /**
     *  按点名老师排序
     */
    CallTaskSortTypeByTeacher = 1,
    /**
     *  按年级班级排序
     */
    CallTaskSortTypeByClass = 2
};

/**
 *  签到状态
 */
typedef NS_ENUM(NSUInteger, SignStatus) {
    /**
     *  已签到
     */
    SignStatusSigned
};

@interface CommonEnums : NSObject

+ (NSString *)TaskStatusName:(TaskStatus)TaskStatus;

+ (NSString *)messageTypeName:(MessageType)messageType;

+ (NSString *)noticesTypeName:(NoticesType)noticesType;

+ (NSString *)relationShipTypeName:(RelationShipType)type;

+ (NSString *)callTaskSortTypeName:(CallTaskSortType)sortType;

+ (NSString *)signStatusName:(SignStatus)staus;

@end
