//
//  TodoContentView.h
//  dsdl
//
//  Created by 廉英雷 on 16/11/17.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^todoContentBlock)(NSString *str,NSString *agree);

@interface TodoContentView : UIView

@property (nonatomic, strong) NSMutableArray *dataAry;

@property (nonatomic, strong) NSMutableArray *headAry;

@property (nonatomic, copy) todoContentBlock contentBlock;
@end
