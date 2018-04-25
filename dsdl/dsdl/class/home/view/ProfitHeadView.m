//
//  ProfitHeadView.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/9.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "ProfitHeadView.h"
#import "ProfitHeadTableViewCell.h"

@interface ProfitHeadView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UITableView *headView;
@end
@implementation ProfitHeadView

- (instancetype)initWithFrame:(CGRect)frame{

      if (self = [super initWithFrame:frame]) {
            [self creatHeadView];
      }
      return self;
}

- (void)setDataAry:(NSArray *)dataAry{

      _dataAry = dataAry;
    
      [self.headView reloadData];
}
- (void)creatHeadView{

      UITableView *tabView = [[UITableView alloc] initWithFrame:self.bounds];
      [self addSubview:tabView];
      tabView.delegate = self;
      tabView.dataSource = self;
      tabView.scrollEnabled = NO;
      tabView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

      
      ProfitHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profitHeadCell"];
      if (!cell) {
            
            cell = [[NSBundle mainBundle] loadNibNamed:@"ProfitHeadTableViewCell" owner:self options:nil].firstObject;
      }
      
      if (indexPath.row == 0) {
           // cell.contentView.backgroundColor = [UIColor greenColor];
       cell.dateLab.hidden = YES;
            tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            tableView.separatorColor = [UIColor colorWithWhite:0.95 alpha:1.0];
            cell.contentView.backgroundColor = kUIColorFromRGB(0x1f9d85);
            
      }
      if (indexPath.row == 1) {
            NSArray *ary = self.dataAry[0];
            cell.dateLab.text = @"1#机组";
            cell.proLab.text = ary[0];
            //cell.proLab.textColor = kUIColorFromRGB(0x8ecdf6);
            cell.heatLab.text = ary[1];
            //cell.heatLab.textColor = kUIColorFromRGB(0xf89679);
            cell.proLLab.text = ary[2];
            //cell.proLLab.textColor = kUIColorFromRGB(0xfad680);
            
      }
      if (indexPath.row == 2) {
            NSArray *ary = self.dataAry[1];
            cell.dateLab.text = @"2#机组";
            cell.proLab.text = ary[0];
            cell.heatLab.text = ary[1];
            cell.proLLab.text = ary[2];
      }
      return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      
      return 3;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
