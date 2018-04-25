//
//  HomeModel.h
//  dsdl
//
//  Created by 廉英雷 on 17/1/6.
//  Copyright © 2017年 廉英雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject


//createTime = "2016-12-19 00:00:00";
//heatingAmount = 1;
//id = 1;
//loadRate = 1;
//powerAmount = 1;
//unitSet = 1;

//"activePowerV1": "2",
//"activePowerV2": "2",
//"agcV1": "2",
//"agcV2": "2",
//"createTime": "2017-01-16 12:00:00",
//"heatingLoadV1": "2",
//"heatingLoadV2": "2",
//"id": "2",
//"loadRateV1": "2",
//"loadRateV2": "2",
//"loadV1": "2",
//"loadV2": "2"

//机组

@property(nonatomic,copy) NSString *activePowerV1;

@property(nonatomic,copy) NSString *activePowerV2;

/**
 *  AGC 指令
 */
@property(nonatomic,copy) NSString *agcV1;

@property(nonatomic,copy) NSString *agcV2;

/**
 *  供热量
 */
@property(nonatomic,copy) NSString *heatingLoadV1;

@property(nonatomic,copy) NSString *heatingLoadV2;

/**
 *  负荷率
 */
@property(nonatomic,copy) NSString *loadRateV1;

@property(nonatomic,copy) NSString *loadRateV2;

/**
 *  负荷
 */
@property(nonatomic,copy) NSString *loadV1;

@property(nonatomic,copy) NSString *loadV2;



//------

@property(nonatomic,copy) NSString *createTime;

@property(nonatomic,copy) NSString *heatingAmount;

@property(nonatomic,copy) NSString *id;

@property(nonatomic,copy) NSString *loadRate;

@property(nonatomic,copy) NSString *powerAmount;

@property(nonatomic,copy) NSString *unitSet;
@end
