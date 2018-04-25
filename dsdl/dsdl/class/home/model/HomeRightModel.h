//
//  HomeRightModel.h
//  dsdl
//
//  Created by 廉英雷 on 16/12/30.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeRightModel : NSObject

//"createTime": "2016-12-30 05:00:00",
//"id": "1",
//"planProfitsV1": "250000",
//"planProfitsV2": "300000",
//"profitsV1": "200000",
//"profitsV2": "190000",
//"totalDay": "",
//"totalMonth": ""

@property(nonatomic,copy) NSString *createTime;

@property(nonatomic,copy) NSString *id;

@property(nonatomic,copy) NSString *planProfitsV1;

@property(nonatomic,copy) NSString *planProfitsV2;

@property(nonatomic,copy) NSString *profitsV1;

@property(nonatomic,copy) NSString *profitsV2;

@property(nonatomic,copy) NSString *totalDay;

@property(nonatomic,copy) NSString *totalMonth;
@end
