//
//  YLSatatusTool.h
//  dsdl
//
//  Created by 廉英雷 on 17/2/8.
//  Copyright © 2017年 廉英雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLSatatusTool : NSObject

+ (instancetype)shareStatusTool;
//拼接文件储存路径
-(void)filePath:(NSString *)filePath;

//读数据
- (NSMutableArray *)readShops;

//储存数据
- (void)addShops:(NSArray *)dataArray;


/**
 *  根据请求参数去沙盒中加载缓存的微博数据
 *
 *  @param params 请求参数
 */
//+ (NSArray *)statusesWithParams:(NSDictionary *)params;
//
///**
// *  存储微博数据到沙盒中
// *
// *  @param statuses 需要存储的微博数据
// */
//+ (void)saveStatuses:(NSArray *)statuses;
@end
