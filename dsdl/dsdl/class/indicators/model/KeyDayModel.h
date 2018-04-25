//
//  KeyDayModel.h
//  dsdl
//
//  Created by 廉英雷 on 16/12/27.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyDayModel : NSObject

//            "createTime": "2016-12-19 12:00:00",
//            "electricityPlanV1": "1",
//            "electricityPlanV2": "1",
//            "electricityV1": "1",
//            "electricityV2": "1",
//            "generationPlanV1": "1",
//            "generationPlanV2": "1",
//            "id": "1",
//            "powerGenerationV1": "1",
//            "powerGenerationV2": "1",
//            "powerSupplyV1": "1",
//            "powerSupplyV2": "1",
//            "supplyPlanV1": "1",
//            "supplyPlanV2": "1"

@property(nonatomic,copy) NSString *createTime;

@property(nonatomic,copy) NSString *electricityPlanV1;

@property(nonatomic,copy) NSString *electricityPlanV2;

@property(nonatomic,copy) NSString *electricityV1;

@property(nonatomic,copy) NSString *electricityV2;

@property(nonatomic,copy) NSString *generationPlanV1;

@property(nonatomic,copy) NSString *generationPlanV2;

@property(nonatomic,copy) NSString *powerGenerationV1;

@property(nonatomic,copy) NSString *powerGenerationV2;

@property(nonatomic,copy) NSString *powerSupplyV1;

@property(nonatomic,copy) NSString *powerSupplyV2;

@property(nonatomic,copy) NSString *supplyPlanV1;

@property(nonatomic,copy) NSString *supplyPlanV2;



@end
