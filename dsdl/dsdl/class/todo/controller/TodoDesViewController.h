//
//  TodoDesViewController.h
//  dsdl
//
//  Created by 廉英雷 on 16/11/17.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

typedef  void (^todoDesViewControllerBlock)();
#import "BaseViewController.h"


@interface TodoDesViewController : BaseViewController

@property(nonatomic,copy) NSString * _Nullable  descrStr;

@property (nonnull, copy) todoDesViewControllerBlock todoDesVCBlock;
@end
