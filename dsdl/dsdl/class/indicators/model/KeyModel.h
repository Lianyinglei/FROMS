//
//  KeyModel.h
//  dsdl
//
//  Created by 廉英雷 on 16/12/19.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyModel : NSObject

//"createTime": "2016-12-19 12:00:00",
//"electricity": "1",
//"electricityPlan": "1",
//"generationPlan": "1",
//"id": "1",
//"powerGeneration": "1",
//"powerSupply": "1",
//"supplyPlan": "1"

//创建时间
@property(nonatomic,copy) NSString *createTime;

//发电量
@property(nonatomic,copy) NSString *powerGeneration;


//计划发电量
@property(nonatomic,copy) NSString *generationPlan;

//供电量
@property(nonatomic,copy) NSString *powerSupply;

//计划供电量
@property(nonatomic,copy) NSString *supplyPlan;

//厂用电量
@property(nonatomic,copy) NSString *electricity;

//计划厂用电量
@property(nonatomic,copy) NSString *electricityPlan;


@end
