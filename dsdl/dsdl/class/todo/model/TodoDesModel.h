//
//  TodoDesModel.h
//  dsdl
//
//  Created by 廉英雷 on 16/12/19.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodoDesModel : NSObject

//"demandTotal": "1",
//"detailId": "1",
//"lineCost": "1",
//"no": "1",
//"suppliesName": "1",
//"unit": "1",
//"unitCost": "1",
//"warehouse": "1"

/**
 *  序号
 */
@property(nonatomic,copy) NSString *no;

/**
 *  待办详情id
 */

@property(nonatomic,copy) NSString *detailId;


/**
 *  物资名称
 */
@property(nonatomic,copy) NSString *suppliesName;

/**
 *  需求数量
 */
@property(nonatomic,copy) NSString *demandTotal;

/**
 *  单位成本
 */
@property(nonatomic,copy) NSString *unitCost;

/**
 *  行成本
 */
@property(nonatomic,copy) NSString *lineCost;

/**
 *  库房
 */
@property(nonatomic,copy) NSString *warehouse;


/**
 *  单位
 */
@property(nonatomic,copy) NSString *unit;


@end
