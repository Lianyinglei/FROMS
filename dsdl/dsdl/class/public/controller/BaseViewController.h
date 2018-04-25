//
//  BaseViewController.h
//  MovePower
//
//  Created by Femto03 on 14-6-5.
//  Copyright (c) 2014年 Kyson. All rights reserved.
//

@import UIKit;
#import "HttpRequest.h"
typedef void (^baseBlock)();
@class MBProgressHUD;
@interface BaseViewController : UIViewController<UIAlertViewDelegate,HttpRequestDelegate>
@property(nonatomic,strong)HttpRequest * httpRequest;

@property (copy, nonatomic) NSString *statusStr;

//@property (nonatomic ,copy) baseBlock baseBlock;


@property (nonatomic, strong) MBProgressHUD  *hud;

-(void)customNavigationBar;

-(void)leftNavigationBarButtonClick;





//显示连接蓝牙提示
//- (void)showConnectionAlert;

- (void)backAction:(UIButton *)button;

-(void)showHUD:(NSString *)title afterTime:(double)seconds failStr:(NSString *)str;

//隐藏加载
- (void)hideHUD;

-(void)showProgressWithStatus:(NSString *)status;
-(void)hideProgressAfterDelaysInSeconds:(float)seconds;
-(void)hideProgressAfterDelaysInSeconds:(float)seconds withCompletion:(void (^)())completion;

- (void)showHUDDelayHid:(NSString *)title;

//显示加载
- (void)showHUD:(NSString *)title;

//隐藏加载显示加载完成提示
- (void)hideHUDWithTitle:(NSString *)title;

//显示提示
- (void)showTipView:(NSString *)tip;
- (void)initView;

@end
