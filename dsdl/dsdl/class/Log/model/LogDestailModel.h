//
//  LogDestailModel.h
//  dsdl
//
//  Created by 廉英雷 on 16/11/28.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogDestailModel : NSObject

//"content": "dsafdsafdsafsa",
//"contentDescribe": "1",
//"execute": "Y",
//"executeExplain": "1",
//"extended": "1",
//"extendedReason": "1",
//"flight": "1",
//"id": "1",
//"no": "1",
//"type": "1"

//编号
@property(nonatomic,copy) NSString *no;

//执行说明
@property(nonatomic,copy) NSString *executeExplain;

//顺延
@property(nonatomic,copy) NSString *extended;

//顺延原因
@property(nonatomic,copy) NSString *extendedReason;

//日期
@property(nonatomic,copy) NSString *date;

//类别
@property(nonatomic,copy) NSString *type;

//班次
@property(nonatomic,copy) NSString *flight;


//描述内容
@property(nonatomic,copy) NSString *contentDescribe;


//---------------记事内容的model---------------

//"context": "Aaron测试数据",
//"id": "1",
//"notepadPerson": "1",
//"type": "1"

//内容
@property(nonatomic,copy) NSString *context;

//记事人
@property(nonatomic,copy) NSString *notepadPerson;

//时间
@property(nonatomic,copy) NSString *dateTime;


//-----------------------------------------

//日期
@property (nonatomic,copy) NSString *headDate;

//天气
@property(nonatomic,copy) NSString *weather;

///**
// *  编号
// */
//@property (nonatomic, copy) NSString *numStr;
//
///**
// *  描述内容
// */
//@property (nonatomic, copy) NSString *describStr;
//
///**
// *  执行
// */
//
//@property(nonatomic,copy) NSString *performStr;
//
///**
// *  顺延
// */
//@property(nonatomic,copy) NSString *postStr;
//
///**
// *  顺延原因
// */
//@property(nonatomic,copy) NSString *pWhyStr;
//
//
///**
// *  时间
// */
//@property (nonatomic, copy) NSString *dateStr;
//
//
///**
// *  内容
// */
//@property (nonatomic, copy) NSString *deatilDescriStr;

@end
