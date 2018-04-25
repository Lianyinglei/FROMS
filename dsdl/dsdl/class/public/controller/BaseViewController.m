                                                                                                                   //
//  BaseViewController.m
//  MovePower
//
//  Created by Femto03 on 14-6-5.
//  Copyright (c) 2014年 Kyson. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"
#import "LPPopup.h"
#import "AFNetworking.h"

#import "KVNProgress.h"
#import "NoNetViewController.h"




@interface BaseViewController ()
//{
//    NSTimer *timer;
//    BOOL hasSettedParam;
//    BOOL hasDone;
//}


@end

@implementation BaseViewController

#pragma mark--UI

- (void)viewWillAppear:(BOOL)animated{

      [super viewWillAppear:animated];
      [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}
-(void)customNavigationBar;
{
      self.navigationController.navigationBar.barTintColor = kUIColorFromRGB(0x02b2a2a);
      self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
      //设置导航栏半透明消失
      self.navigationController.navigationBar.translucent = NO;
      
      //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
      
      if (self.navigationController.viewControllers.count > 1) {
            UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
            leftButton.frame = CGRectMake(0, 0, 20, 20);
            leftButton.backgroundColor = [UIColor clearColor];
            [leftButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
            [leftButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
           
            self.navigationItem.leftBarButtonItem = leftItem;
      }
}

-(void)leftBarButtonClick;
{
      [self.navigationController popViewControllerAnimated:YES];
}

-(void)leftNavigationBarButtonClick
{
      [self.navigationController popViewControllerAnimated:YES];
      self.tabBarController.tabBar.hidden = YES;
      
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
      if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
            
            self.httpRequest=[[HttpRequest alloc]init];
            self.httpRequest.delegate=self;
            
      }
      return self;
}




-(void)errorRequest:(id)data withSender:(NSString *)sender{
      
            NSDictionary *dict = (NSDictionary *)data;
           // [self showTipView:dict[@"errmsg"]];
      NSLog(@"报错信息errorRequest---%@",dict[@"errmsg"]);

}
- (void)netFailedWithError:(NSError *)error{
      NSString *str = [error localizedDescription];
      NSLog(@"报错信息netFail-----%@",str);
      
//      NoNetViewController *noVC = [[NoNetViewController alloc] init];
//      UIViewController *controVC = self.navigationController.viewControllers.lastObject;
//      
//    //  NSArray *ary = self.navigationController.viewControllers;
//      if (self.navigationController.viewControllers.count >0 && ![controVC isKindOfClass:[self class]]) {
//            
//             [self.navigationController pushViewController:noVC animated:YES];
//      }
//     
      
      
//      UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, _width, _height-108)];
//      backView.backgroundColor = [UIColor redColor];
//      [self.view addSubview:backView];
     // [[Tools shareTools] alert:str :nil];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSLog(@"sssssssssuper");
    
    if (alertView.tag == 44) {
        if (buttonIndex == 0) {
           
              
                   }
    }
    
}


#pragma mark - HUB
//显示加载
- (void)showHUD:(NSString *)title {
//    if (_hud) {
//        
//        self.hud.labelText = title;
//        [self.hud show:YES];
//        
//    }else{
//        
//        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        self.hud.labelText = title;
//    }
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = title;

}
-(void)showHUD:(NSString *)title afterTime:(double)seconds failStr:(NSString *)str{
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = title;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (_hud) {
            [_hud hide:YES];
            _hud = nil;
            [self showTipView:str];
        }
        
    });
    
    
}

- (void)showHUDDelayHid:(NSString *)title {
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = title;
    
    [self performSelector:@selector(hideHUD) withObject:nil afterDelay:1];
}

//隐藏加载
- (void)hideHUD {
    if (_hud) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_hud hide:YES];
            _hud = nil;
        });
    }
    
    //[self.hud hide:YES];
    
}

//隐藏加载显示加载完成提示
- (void)hideHUDWithTitle:(NSString *)title
{
    self.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    self.hud.mode = MBProgressHUDModeCustomView;
    
    self.hud.labelText = title;
    [self.hud hide:YES afterDelay:1];
    
}


#pragma mark -
#pragma mark - show tip
- (void)showTipView:(NSString *)tip
{
    LPPopup *popup = [LPPopup popupWithText:tip];
    popup.popupColor = [UIColor blackColor];
    popup.textColor = [UIColor whiteColor];
    
    [popup showInView:self.view
        centerAtPoint:self.view.center
             duration:kLPPopupDefaultWaitDuration
           completion:nil];
}


-(void)showProgressWithStatus:(NSString *)status{
    [KVNProgress showWithStatus:status];
}
-(void)hideProgressAfterDelaysInSeconds:(float)seconds{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [KVNProgress dismiss];
    });
}
-(void)hideProgressAfterDelaysInSeconds:(float)seconds withCompletion:(void (^)())completion{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [KVNProgress dismiss];
        completion();
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
      [self customNavigationBar];
      [self initView];
    
      
    KVNProgressConfiguration *basicConfiguration = [KVNProgressConfiguration defaultConfiguration];
    basicConfiguration.fullScreen = YES;
    [KVNProgress setConfiguration:basicConfiguration];

}

- (void)initView{


}
- (void)backAction:(UIButton *)button
{

        if ([self.navigationController.viewControllers count] > 1) {
            [self.navigationController popViewControllerAnimated:YES];
              
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    
}









//-(void)startTimer
//{
//    [timer invalidate];
//    
//    timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(stopTimer) userInfo:NULL repeats:NO];
//}




@end
