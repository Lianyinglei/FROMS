//
//  LogContentView.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/15.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "LogContentView.h"
#import "LogTableViewCell.h"
#import "LogModel.h"

#import "LogFrameModel.h"

@interface LogContentView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tabView;

@end
@implementation LogContentView

- (void)setDataAry:(NSMutableArray *)dataAry{

      _dataAry = dataAry;
      
//      for (LogModel *logModel in dataAry) {
//           // LogFrameModel *logFrame = [[LogFrameModel alloc] init];
//           // logFrame.logModel = logModel;
//            [_dataAry addObject:logModel];
//      }
      [self.tabView reloadData];
}


- (instancetype)initWithFrame:(CGRect)frame{

      if (self = [super initWithFrame:frame]) {
            [self creatContentView];
      }
      return self;
}

- (void)creatContentView{

      self.tabView = [[UITableView alloc] initWithFrame:self.bounds];
      [self addSubview:self.tabView];
      self.tabView.delegate = self;
      self.tabView.dataSource = self;
      self.tabView.rowHeight = 80;
      self.tabView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


      return self.dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

      LogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"logCell1"];
      if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"LogTableViewCell" owner:self options:nil].lastObject;
      }
      
//      if (indexPath.row%2) {
//             cell.imgView.image = [UIImage imageNamed:@"yes.png"];
//      }else{
//      
//             cell.imgView.image = [UIImage imageNamed:@"no.png"];
//      }
       LogModel *logModel = self.dataAry[indexPath.row];
      
      
      //NSArray *oneLogAry = logModel.regularWorks;
      
      
      if ([logModel.status isEqualToString:@"0"]) {
              cell.imgView.image = [UIImage imageNamed:@"yes.png"];
      }
      if ([logModel.status isEqualToString:@"1"]) {
            cell.imgView.image = [UIImage imageNamed:@"no.png"];
      }
      
      cell.nameLab.text = logModel.langName;
      cell.dateLab.text = logModel.createTime;
      cell.contentLab.text = logModel.jobTitle;
      cell.weatherLab.text = logModel.weather;
      
      
      return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      
      LogModel *logModel = self.dataAry[indexPath.row];
      
      if ([self.delegate respondsToSelector:@selector(deseleLogCollectionCell: withId:)]) {
           
            [self.delegate deseleLogCollectionCell:indexPath withId:logModel.id];
      }
      
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
