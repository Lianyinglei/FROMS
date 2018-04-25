//
//  UnitContentView.m
//  dsdl
//
//  Created by 廉英雷 on 17/1/11.
//  Copyright © 2017年 廉英雷. All rights reserved.
//

#import "UnitContentView.h"
#import "CoalTableViewCell.h"
@interface UnitContentView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UITableView *tabView;
@end

@implementation UnitContentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{

      if (self = [super initWithFrame:frame]) {
            [self creatView];
      }
      
      return self;
}

- (void)setDataAry:(NSArray *)dataAry{

      _dataAry = dataAry;
      [self.tabView reloadData];
}
- (void)setTextAry:(NSArray *)textAry{

      _textAry = textAry;
     // [self.tabView reloadData];
}

- (void)creatView{
      
      UITableView *tabView = [[UITableView alloc] initWithFrame:self.bounds];
      [self addSubview:tabView];
      self.tabView = tabView;
      tabView.delegate = self;
      tabView.dataSource = self;
      tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
      
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
      
      return self.textAry.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      NSArray *ary = self.textAry[section];
      return ary.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
      if (section == 0) {
            return 0;
      }else{
      
            return 10;
      }
      
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
      UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _width, 40)];
      //[self.view addSubview:lab1];
      lab1.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
      
      lab1.textAlignment = NSTextAlignmentLeft;
      
//      if (section == 0) {
//            lab1.text = @"    锅炉";
//      }
//      if (section == 1) {
//            lab1.text = @"    汽机";
//      }if (section == 2) {
//            lab1.text = @"    给水流量";
//      }
      
      return lab1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
      
      CoalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"coalCell"];
      if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"CoalTableViewCell" owner:self options:nil].lastObject;
      }
      
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
      NSArray *ary = self.dataAry[indexPath.section];
      NSArray *textArray = self.textAry[indexPath.section];
      cell.coalLab.text = textArray[indexPath.row];
      cell.lineView.hidden = NO;
      if (indexPath.row != 0) {
           //cell.oneLab.text = [NSString stringWithFormat:@"%.2f", [ary[indexPath.row][0] floatValue]];
            cell.oneLab.text = [Tools getNumberTwo:ary[indexPath.row][0]];
           // cell.twoLab.text = [NSString stringWithFormat:@"%.2f", [ary[indexPath.row][1] floatValue]];
            cell.twoLab.text = [Tools getNumberTwo:ary[indexPath.row][1]];
      }else{
            cell.oneLab.text = ary[indexPath.row][0];
            cell.twoLab.text = ary[indexPath.row][1];
      }
     
      
      cell.coalLab.backgroundColor = [UIColor clearColor];
      cell.contentView.backgroundColor = [UIColor clearColor];
      if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                  cell.contentView.backgroundColor = themeColor;
            }else{
            
           // cell.coalLab.backgroundColor = kUIColorFromRGB(0xe7f7fd);
            cell.coalLab.backgroundColor = kUIColorFromRGB(0xa3e5d9);
                  
            }
            
      }
      
      if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                  cell.contentView.backgroundColor = kUIColorFromRGB(0x02b4f0);
            }else{
            
                  cell.coalLab.backgroundColor = kUIColorFromRGB(0xe7f7fd);
            }
            
            
      }
      
      if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                  cell.contentView.backgroundColor = kUIColorFromRGB(0x02b4f0);
            }else{
                  
                  cell.coalLab.backgroundColor = kUIColorFromRGB(0xe7f7fd);
            }
            
            
      }

      if (indexPath.row == 0) {
            
            cell.oneLab.textColor = [UIColor whiteColor];
            cell.twoLab.textColor = [UIColor whiteColor];
            cell.coalLab.textColor = [UIColor whiteColor];
            
            //            cell.coalLab.backgroundColor = themeColor;
            //            cell.oneLab.backgroundColor = themeColor;
            //            cell.twoLab.backgroundColor = themeColor;
      }else{
            
              cell.coalLab.textColor = [UIColor blackColor];
            cell.oneLab.textColor = [UIColor blackColor];
            cell.twoLab.textColor = [UIColor blackColor];
            
      }
      
      
      
      if (_width == IPHONE5W) {
            cell.oneLab.font = [UIFont systemFontOfSize:14];
            cell.twoLab.font = [UIFont systemFontOfSize:14];
            cell.coalLab.font = [UIFont systemFontOfSize:14];
      }else{
      
            cell.oneLab.font = [UIFont systemFontOfSize:17];
            cell.twoLab.font = [UIFont systemFontOfSize:17];
            cell.coalLab.font = [UIFont systemFontOfSize:17];
      }
      
      return cell;
      
      
}

@end
