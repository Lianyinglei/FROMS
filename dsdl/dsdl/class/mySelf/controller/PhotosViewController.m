//
//  PhotosViewController.m
//  dsdl
//
//  Created by 廉英雷 on 17/1/5.
//  Copyright © 2017年 廉英雷. All rights reserved.
//

#import "PhotosViewController.h"

#import "PhotoContenView.h"

@interface PhotosViewController ()<PhotoContentViewDelegate>

@property (nonatomic, strong) NSArray *imgArray;
@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      [self creatView];
      self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
}

- (NSArray *)imgArray{

      if (!_imgArray) {
            _imgArray = @[@"tu01",@"tu02",@"tu03",@"tu04",@"tu05",@"tu06"];
      }
      
      return _imgArray;
}

- (void)viewWillAppear:(BOOL)animated{

      [super viewWillAppear:animated];
      
      self.tabBarController.tabBar.hidden = YES;

}

- (void)creatView{

      PhotoContenView *contentView = [[PhotoContenView alloc] initWithFrame:CGRectMake(0, 0, _width, (_width)/3 *2)];
      contentView.textAry = self.imgArray;
      contentView.delegate = self;
      [self.view addSubview:contentView];
      
}

- (void)deseleCollectionCell:(NSIndexPath *)indexPath{

      self.photoVCBlock(self.imgArray[indexPath.row]);
      [self.navigationController popViewControllerAnimated:YES];
    

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
