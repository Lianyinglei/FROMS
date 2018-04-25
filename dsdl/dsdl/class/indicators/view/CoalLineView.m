//
//  CoalLineView.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/17.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "CoalLineView.h"
#import "CoalTableViewCell.h"
#import "CoalCell.h"

@interface CoalLineView ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, weak) UITableView *tabView;
@property (nonatomic, strong) NSArray *textAry;

@property (nonatomic, strong) NSArray *colorArray;


@end
@implementation CoalLineView

- (void)setDataAry:(NSArray *)dataAry{

      _dataAry = dataAry;
     // _dataAry =@[@[@"一号机组",@"二号机组"],@[@"223",@"213"],@[@"224",@"213"],@[@"16.3",@"16.7"]];
      
      [self.tabView reloadData];
}

- (NSArray *)colorArray{

      if (!_colorArray) {
            _colorArray = [[NSArray alloc] init];
            _colorArray = @[[UIColor clearColor],kUIColorFromRGB(0x0ead6b),kUIColorFromRGB(0x00a5d3),kUIColorFromRGB(0xfd9602)];
      }
      return _colorArray;
}
- (NSArray *)textAry{

      if (!_textAry) {
            _textAry = @[@"",@"供电煤耗\ng/kWh",@"发电煤耗\ng/kwh",@"厂用电率\n(%)"];
      }
      return _textAry;
}
- (instancetype)initWithFrame:(CGRect)frame{


      if (self = [super initWithFrame:frame]) {
            [self creatView];
      }
      return self;
}

- (void)creatView{

      UITableView *tabView = [[UITableView alloc] initWithFrame:self.bounds];
      [self addSubview:tabView];
      tabView.delegate = self;
      tabView.dataSource = self;
      self.tabView = tabView;
      tabView.rowHeight = 50;
      tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

      return self.dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

      CoalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"coalCell"];
      
      if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"CoalCell" owner:self options:nil].lastObject;
      }
//      CoalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"coalCell"];
//      if (!cell) {
//            cell = [[NSBundle mainBundle] loadNibNamed:@"CoalTableViewCell" owner:self options:nil].lastObject;
//      }
     
      
      
            NSArray *ary = self.dataAry[indexPath.row];
      
            cell.coalLab.text = self.textAry[indexPath.row];
    //  cell.lineView.hidden = YES;
      if (indexPath.row != 0) {
            cell.oneLab.text = [NSString stringWithFormat:@"%.2f",[ary[0] floatValue]];
            
            cell.twoLab.text =  [NSString stringWithFormat:@"%.2f",[ary[1] floatValue]];
            cell.oneLab.text = [Tools getNumberTwo:ary[0]];
            cell.twoLab.text = [Tools getNumberTwo:ary[1]];
      }else{
      
            cell.oneLab.text = ary[0];
            cell.twoLab.text =  ary[1];
           
      }
      
      cell.colorView.backgroundColor = self.colorArray[indexPath.row];
      cell.oneLab.font = [UIFont systemFontOfSize:14];
      cell.twoLab.font = [UIFont systemFontOfSize:14];
      
      if (_width == IPHONE5W) {
            cell.coalLab.font = [UIFont systemFontOfSize:12];
      }else{
      cell.coalLab.font = [UIFont systemFontOfSize:14];
      
      }
      
      if (indexPath.row == 0) {
            
            cell.colorView.hidden = YES;
            cell.coalLab.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
      }
      
            return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
