//
//  IndicatorViewController.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/3.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "IndicatorViewController.h"
#import "IndicatorContentView.h"
#import "KeyViewController.h"
#import "CoalViewController.h"
#import "UnitViewController.h"
#import "ProViewController.h"
#import "MyselfViewController.h"
#import "FuleViewController.h"

@interface IndicatorViewController ()<IndicatorContentViewDelegate>

@end

@implementation IndicatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      
      [self creatView];
      
}


- (void)viewWillAppear:(BOOL)animated{
      [super viewWillAppear:animated];
      self.tabBarController.tabBar.hidden = NO;
      
}


- (void)customNavigationBar{

      [super customNavigationBar];
      self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];

      UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
      lab.text = @"数字东胜";
      lab.font = [UIFont systemFontOfSize:18];
      lab.textAlignment = NSTextAlignmentCenter;
      lab.textColor = [UIColor whiteColor];
      self.navigationItem.titleView = lab;

      
//      self.navigationController.navigationBar.barTintColor = kUIColorFromRGB(0x0fa8df);
//      self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//      //设置导航栏半透明消失
//      self.navigationController.navigationBar.translucent = NO;
}
- (void)creatView{
      
      //企业服务，
      //重点关注事项，对标分析，党群工作，
      IndicatorContentView *contentView = [[IndicatorContentView alloc] initWithFrame:CGRectMake(0, 0, _width, _height -124)];
      contentView.delegate = self;
      contentView.userInteractionEnabled = YES;
      contentView.textAry = @[@[@"重点关注",@"对标分析",@"党群工作"],@[@"个人信息"]];
      contentView.imageAry = @[@[@"zhongdian",@"duibiao",@"dangqun"],@[@"grxx_icon"]];
      [self.view addSubview:contentView];

}


#pragma mark -----indictorViewDeleaget -------
- (void)deseleCollectionCell:(NSIndexPath *)indexPath{
      if (indexPath.section ==0) {
            
            [self showTipView:@"等待接入..."];
      }
      if (indexPath.section ==1) {
            if (indexPath.row == 0) {
                  MyselfViewController *myselfVC = [[MyselfViewController alloc] init];
                  [self.navigationController pushViewController:myselfVC animated:YES];
            }
            
            
      }
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
