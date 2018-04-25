//
//  LogModel.h
//  dsdl
//
//  Created by 廉英雷 on 16/11/28.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogModel : NSObject
//crew = 1;
//eamLogId = 1;
//flight = 1;
//id = 1;
//jobTitle = 1;
//langName = 1;
//langValue = 1

//主键
@property (nonatomic,copy) NSString *id;

//日期
@property (nonatomic,copy) NSString *date;

//天气
@property(nonatomic,copy) NSString *weather;

//类别
@property(nonatomic,copy) NSString *type;

//班次
@property(nonatomic,copy) NSString *flight;

//职别
@property(nonatomic,copy) NSString *jobTitle;

//值长
@property(nonatomic,copy) NSString *langValue;

//机组名字
@property(nonatomic,copy) NSString *crewName;

//机组
@property(nonatomic, copy)NSString *crew;

//状态
@property(nonatomic,copy) NSString *status;

//值长名称
@property(nonatomic,copy) NSString *langName;

@property(nonatomic,strong) NSArray *regularWorks;

@property (nonatomic, strong) NSArray *notes;

////创建时间
@property(nonatomic,copy) NSString *createTime;
//
////更新时间
@property(nonatomic,copy) NSString *updateTime;

//eam系统日志id
@property(nonatomic,copy) NSString *eamLogId;
@end
