//
//  TodoModel.h
//  dsdl
//
//  Created by 廉英雷 on 16/12/16.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodoModel : NSObject

//"appName": "你猜",
//"createTime": "创建时间",
//"date": "日期",
//"eamId": "1",
//"eamUserId": "123456",
//"id": "1",
//"isDelete": "0",
//"isRead": "1",
//"status": "状态",
//"tableName": "表名",
//"taskDescribe": "这是只是个描述"

@property(nonatomic,copy) NSString *appName;

@property(nonatomic,copy) NSString *createTime;

@property(nonatomic,copy) NSString *date;

@property(nonatomic,copy) NSString *eamId;

@property(nonatomic,copy) NSString *eamUserId;

@property(nonatomic,copy) NSString *id;

@property(nonatomic,copy) NSString *isDelete;

@property(nonatomic,copy) NSString *isRead;

@property(nonatomic,copy) NSString *tableName;

@property(nonatomic,copy) NSString *taskDescribe;
@end
