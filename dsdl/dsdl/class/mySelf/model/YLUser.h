//
//  YLUser.h
//  dsdl
//
//  Created by 廉英雷 on 17/2/24.
//  Copyright © 2017年 廉英雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLUser : NSObject

/**
 *  登录账号
 */
@property(nonatomic,copy) NSString *account;

/**
 *  创建时间
 */
@property(nonatomic,copy) NSString *createTime;

/**
 *  部门
 */

@property(nonatomic,copy) NSString *department;

/**
 * 名字
 */
@property(nonatomic,copy) NSString *name;

@property(nonatomic,copy) NSString *headimg;

/**
 *  岗位
 */
@property(nonatomic,copy) NSString *position;

/**
 *  手机号
 */
@property(nonatomic,copy) NSString *phone;

@end
