//
//  ProModel.h
//  dsdl
//
//  Created by 廉英雷 on 16/12/21.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProModel : NSObject
//                  "createTime": "2016-12-19 12:00:00",
//                  "desulfurizationNitrate": "2",脱硝效率值
//                  "desulfurizationSulfur": "2",脱硫效率值
//                  "id": "2",
//                  "nitrateCeiling": "2", 脱硝上限值
//                  "nox": "2", NOx值
//                  "noxCeiling": "2", NOx上限值
//                  "somkeDust": "2", 烟尘值
//                  "somkeDustCeiling": "2",烟尘上限值
//                  "sox": "2",       SOx值
//                  "soxCeiling": "2", SOx上限值
//                  "sulfurCeiling": "2", 脱硫上限值
//                  "unitSet": "1" 机组
@property(nonatomic,copy) NSString *desulfurizationNitrate;

@property(nonatomic,copy) NSString *desulfurizationSulfur;

@property(nonatomic,copy) NSString *nitrateCeiling;

@property(nonatomic,copy) NSString *nox;

@property(nonatomic,copy) NSString *noxCeiling;

@property(nonatomic,copy) NSString *somkeDust;

@property(nonatomic,copy) NSString *somkeDustCeiling;

@property(nonatomic,copy) NSString *sox;

@property(nonatomic,copy) NSString *soxCeiling;

@property(nonatomic,copy) NSString *sulfurCeiling;

@property(nonatomic,copy) NSString *unitSet;

@property(nonatomic,copy) NSString *createTime;
@end

