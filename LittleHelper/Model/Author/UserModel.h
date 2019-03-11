//
//  UserModel.h
//  lantu
//
//  Created by Eric Wang on 15/7/5.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "BaseModel.h"
#import "AutoCoding.h"

@interface UserModel : BaseModel

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *accountStatus;

@property (nonatomic, copy) NSString *accountType;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *companyid;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *companyname;

@end

@interface companyModel : BaseModel

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *name;

@end