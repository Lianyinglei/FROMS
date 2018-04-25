//
//  PhotosViewController.h
//  dsdl
//
//  Created by 廉英雷 on 17/1/5.
//  Copyright © 2017年 廉英雷. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^photoViewControllerBlock) (NSString * imgStr);

@interface PhotosViewController : BaseViewController

@property (nonatomic, copy) photoViewControllerBlock photoVCBlock;
@end
