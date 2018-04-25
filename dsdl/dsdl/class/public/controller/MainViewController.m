//
//  MainViewController.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/3.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "LoginViewController.h"
#import "MyselfViewController.h"
#import "IndicatorViewController.h"
#import "LogViewController.h"
#import "BaseNavgationViewController.h"
#import "TodoViewController.h"
#import "ANTabBarItem.h"
#import "MyselfViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     
      [self addViewControlls];
      
      self.tabBarController.selectedViewController = [self.viewControllers objectAtIndex:1];
      
}

+(instancetype)shareMainViewController;
{
      static MainViewController * mainController=nil;
      static dispatch_once_t  tocken;
      dispatch_once(&tocken, ^{
            mainController=[[MainViewController alloc]init];
      });
      return mainController;
}
- (void)addViewControlls{
      HomeViewController *homeVC = [[HomeViewController alloc] init];
      BaseNavgationViewController *navHome = [[BaseNavgationViewController alloc] initWithRootViewController:homeVC];
      IndicatorViewController *indictorsVC = [[IndicatorViewController alloc] init];
      BaseNavgationViewController *navIndictor = [[BaseNavgationViewController alloc] initWithRootViewController:indictorsVC];
      LogViewController *logVC = [[LogViewController alloc] init];
      BaseNavgationViewController *navLog = [[BaseNavgationViewController alloc] initWithRootViewController:logVC];
      TodoViewController *todoVC = [[TodoViewController alloc] init];
      BaseNavgationViewController *navMyself = [[BaseNavgationViewController alloc] initWithRootViewController:todoVC];
      MyselfViewController *mySelfVC = [[MyselfViewController alloc] init];
      BaseNavgationViewController *navMy = [[BaseNavgationViewController alloc] initWithRootViewController:mySelfVC];

      [self addChildViewController:navHome];
       [self addChildViewController:navMyself];
      [self addChildViewController:navLog];
     
      [self addChildViewController:navMy];
     // [self addChildViewController:navIndictor];
      NSArray * images=@[@"tabhome-nomal",@"tabDai-nomal",@"tabmy-nomal",@"gr—h"];
      NSArray * selectImages=@[@"tabhome-select",@"daiban",@"tabmy-select",@"ger"];
      NSArray * titles=@[@"首页",@"待办",@"日志",@"个人"];
      
      [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            ANTabBarItem *tabBarItem = [[ANTabBarItem alloc] init];
            
            obj.tabBarItem = tabBarItem;
            
            obj.tabBarItem.image=[[UIImage imageNamed:images[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            obj.tabBarItem.selectedImage=[[UIImage imageNamed: selectImages[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            obj.tabBarItem.title=titles[idx];
           
            
      }];
      
      for (UIBarItem *item in self.tabBar.items) {
            [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont fontWithName:@"Helvetica" size:13.0], NSFontAttributeName, nil]
                                forState:UIControlStateNormal];
            
      }

      [[UITabBar appearance]setTintColor:[UIColor whiteColor]];
      [[UITabBar appearance]setSelectedImageTintColor:[UIColor whiteColor]];
//      
      CGSize selectSize = CGSizeMake(self.tabBar.bounds.size.width/self.tabBar.items.count, self.tabBar.bounds.size.height);
      self.tabBar.selectionIndicatorImage = [self drawTabBarItemBackgroundImageWithSize:selectSize];

      
}


- (UIImage *)drawTabBarItemBackgroundImageWithSize:(CGSize)size
{
      // 准备绘图环境
      UIGraphicsBeginImageContext(size);
      CGContextRef ctx = UIGraphicsGetCurrentContext();
      
      CGContextSetRGBFillColor(ctx, 57.0 / 255, 143.0 / 255, 114.0 / 255, 1);
      CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
      
      // 获取该绘图中的图片
      UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
      
      //结束绘图
      UIGraphicsEndImageContext();
      
      
      /*
       // 获取当前应用路径中Documents目录下指定文件名对应的文件路径
       NSString *path = [[NSHomeDirectory() stringByAppendingString:@"/Documents"] stringByAppendingString:@"/tabBarBackgroundImage.png"];
       NSLog(@"path:%@", path);
       // 保存PNG图片
       [UIImagePNGRepresentation(img) writeToFile:path atomically:YES];
       */
      return img;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
