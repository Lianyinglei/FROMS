//
//  TodoHeadModel.h
//  dsdl
//
//  Created by 廉英雷 on 16/12/29.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodoHeadModel : NSObject

//"applyDepartment": 申请部门,
//"applyMajor": 申请专业,
//"applyPerson": 申请人,
//"applyTime": 申请时间,
//"budgetProject": 预算项目,
//"commissionId": 待办列表id,
//"createTime": 创建时间,
//"describe": 描述,
//"id": "",
//"no": 编号,
//"planTotal": 计划单总费用,
//"status": 状态,
//"type": 类别

@property(nonatomic,copy) NSString *applyDepartment;

@property(nonatomic,copy) NSString *applyMajor;

@property(nonatomic,copy) NSString *applyPerson;

@property(nonatomic,copy) NSString *applyTime;

@property(nonatomic,copy) NSString *budgetProject;

@property(nonatomic,copy) NSString *commissionId;

@property(nonatomic,copy) NSString *describe;

@property(nonatomic,copy) NSString *createTime;

@property(nonatomic,copy) NSString *no;

@property(nonatomic,copy) NSString *id;

@property(nonatomic,copy) NSString *planTotal;

@property(nonatomic,copy) NSString *status;

@property(nonatomic,copy) NSString *type;

@property(nonatomic,copy) NSString *taskDescribe;

@property(nonatomic,copy) NSString *details;

@end
