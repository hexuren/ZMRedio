//
//  CommonEnums.m
//  wutuobang
//
//  Created by Eric Wang on 16/4/25.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CommonEnums.h"

@implementation CommonEnums

+ (NSString *)TaskStatusName:(TaskStatus)TaskStatus{
    switch (TaskStatus) {
        case TaskStatusNew:{
            return @"新建任务";
            break;
        }
        case TaskStatusUnderWay:{
            return @"巡检中";
            break;
        }
        case TaskStatusComplete:{
            return @"巡检完成";
            break;
        }
        case TaskStatusAuditing:{
            return @"审核中";
            break;
        }
        case TaskStatusAuditComplete:{
            return @"已审核";
            break;
        }
        default:
            break;
    }
}

+ (NSString *)messageTypeName:(MessageType)messageType{
    switch (messageType) {
        case powerTask: {
            return @"powerTask";
            break;
        }
        case powerApproval: {
            return @"powerApproval";
            break;
        }
        case powerReport: {
            return @"powerReport";
            break;
        }
        case contract: {
            return @"contract";
            break;
        }
    }
}

+ (NSString *)noticesTypeName:(NoticesType)noticesType{
    switch (noticesType) {
        case SystemNotice:{
            return @"系统公告";
            break;
        }
        case ResultsNotice:{
            return @"业绩公告";
            break;
        }
        case HolidayNotice:{
            return @"假期公告";
            break;
        }
        case PersonnelNotice:{
            return @"人事公告";
            break;
        }
        case OtherNotice:{
            return @"其他公告";
            break;
        }
        default:
            break;
    }
}

+ (NSString *)relationShipTypeName:(RelationShipType)type{
    switch (type) {
        case RelationShipTypeFather: {
            return @"父亲";
            break;
        }
        case RelationShipTypeMother: {
            return @"母亲";
            break;
        }
        case RelationShipTypeBrotherOrSister: {
            return @"兄弟姐妹";
            break;
        }
        case RelationShipTypeGrandpa: {
            return @"爷爷";
            break;
        }
        case RelationShipTypeGrandma: {
            return @"奶奶";
            break;
        }
    }
}

+ (NSString *)callTaskSortTypeName:(CallTaskSortType)sortType{
    switch (sortType) {
        case CallTaskSortTypeByTeacher: {
            return @"teacher";
            break;
        }
        case CallTaskSortTypeByClass: {
            return @"class";
            break;
        }
        case CallTaskSortTypeByTime: {
            return @"sign";
            break;
        }
    }
}

+ (NSString *)signStatusName:(SignStatus)staus{
    switch (staus) {
        case SignStatusSigned: {
            return @"signed";
            break;
        }
    }
}

@end
