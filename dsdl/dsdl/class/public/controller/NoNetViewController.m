//
//  NoNetViewController.m
//  dsdl
//
//  Created by 廉英雷 on 17/1/6.
//  Copyright © 2017年 廉英雷. All rights reserved.
//

#import "NoNetViewController.h"

@interface NoNetViewController ()

@end

@implementation NoNetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      
      self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
      
      UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.centerX, self.view.centerY, 100, 100)];
      
      imgView.center = self.view.center;
      imgView.image = [UIImage imageNamed:@"noNet.png"];
      [self.view addSubview:imgView];
      imgView.contentMode = UIViewContentModeScaleAspectFit;
      
      
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
