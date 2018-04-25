//
//  LogDesContenView.m
//  dsdl
//
//  Created by 廉英雷 on 17/1/1.
//  Copyright © 2017年 廉英雷. All rights reserved.
//

#import "LogDesContenView.h"

#import "LogFrameModel.h"

#import "LogDestailCell.h"
#import "LogLab.h"
#import "LogDestailModel.h"
#import "LogDestailLeftCell.h"
#import "LogDestailLeftModel.h"
#import "LogModel.h"
#import "MJExtension.h"


@interface LogDesContenView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic,weak) UIView *lineView ;

@property (nonatomic, assign) BOOL isHiden;

@property (nonatomic, weak) UILabel *wetLeftLab;

@property (nonatomic, weak) UILabel *dateLab;

@property (nonatomic, weak) UIButton *leftBtn;

@property (nonatomic, weak) UIButton *rightBtn;


@end
@implementation LogDesContenView


//左边数据
- (void)setLeftDataAry:(NSMutableArray *)leftDataAry{

     // _leftDataAry = leftDataAry;
      
      if (_leftDataAry) {
            [_leftDataAry removeAllObjects];
      }else{
      
            _leftDataAry = [NSMutableArray array];
      }
      
      [_leftDataAry addObject:self.headArray];
      NSMutableArray *leftAry = [NSMutableArray array];
     
      for (LogDestailModel *desModel in leftDataAry) {
             LogFrameModel *frameMode = [[LogFrameModel alloc] init];
            frameMode.logDestailModel = desModel;
            [leftAry addObject:frameMode];
      }
      [_leftDataAry addObject:leftAry];
      
      [self.tableView reloadData];
      

}

- (void)setHeadArray:(NSMutableArray *)headArray{

     // _headArray = headArray;
      if (_headArray) {
            [_headArray removeAllObjects];
            
      }else{
      
            _headArray = [NSMutableArray array];
      }
      
     
      for (LogDestailModel *desModel in headArray) {
             LogFrameModel *frameModel = [[LogFrameModel alloc] init];
            frameModel.logDestailModel = desModel;
            [_headArray addObject:frameModel];
      }
     
//      LogDestailModel *desModel = headArray[0];
//      self.wetLeftLab.text = desModel.weather;
//      self.dateLab.text = desModel.headDate;
//      [self.tableView reloadData];
}

- (void)setRightDataAry:(NSMutableArray *)rightDataAry{

      if (_rightDataAry) {
            
            [_rightDataAry removeAllObjects];
            
      }else{
      
            _rightDataAry = [NSMutableArray array];
      }
      
      [_rightDataAry addObject:self.headArray];
      
      NSMutableArray *rightAry = [NSMutableArray array];
      
      for (LogDestailModel *desModel in rightDataAry) {
            LogDestailLeftModel *leftModel = [[LogDestailLeftModel alloc] init];
            
            leftModel.logDestailModel = desModel;
            
            [rightAry addObject:leftModel];
      }
      
      [_rightDataAry addObject:rightAry];
      
      [self.tableView reloadData];
}
- (instancetype)initWithFrame:(CGRect)frame{
      
      if (self = [super initWithFrame:frame]) {
            [self creatContentView];
            self.isHiden = YES;
      }
      
      return self;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
      
      if (self.isHiden) {
            if (indexPath.section == 0) {
                  
                  NSArray *ary = self.leftDataAry[indexPath.section];
                  LogFrameModel *frameModel = ary[indexPath.row];
                  return frameModel.cellHight;
                  
            }else{
                  NSArray *ary = self.leftDataAry[indexPath.section];
                  LogFrameModel *frameModel = ary[indexPath.row];
                  return frameModel.cellHight;
                  
            }
            
      }else{
            
            if (indexPath.section == 0) {
                  
                  NSArray *ary = self.rightDataAry[0];
                  LogFrameModel *frameModel = ary[indexPath.row];
                  return frameModel.cellHight;
                  
            }else{
                  NSArray *ary = self.rightDataAry[1];
                  LogDestailLeftModel *frameModel = ary[indexPath.row];
                  return frameModel.cellHight;
                  
            }
            
            
      }
      
      
}
- (void)creatContentView{
      
      UITableView *tabView = [[UITableView alloc] initWithFrame:self.bounds];
      self.tableView = tabView;
      [self addSubview:tabView];
      tabView.delegate = self;
      tabView.dataSource = self;
      tabView.rowHeight = 100;
      tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
      tabView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
      
      //  tabView.tableHeaderView = [self headView];
      
      
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
      return self.leftDataAry.count;
      
      //return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      if (self.isHiden) {
            if (section == 0) {
                  NSArray *ary = self.leftDataAry[section];
                  return ary.count;
            }else  {
                  NSArray *ary = self.leftDataAry[section];
                  return ary.count;
            }
            
      }else{
            if (section == 0) {
                  NSArray *ary = self.rightDataAry[section];
                  return ary.count;
            }else  {
                  NSArray *ary = self.rightDataAry[section];
                  return ary.count;
            }
            
            
      }
      
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
      
      if (self.isHiden) {
            LogDestailCell*cell = [tableView dequeueReusableCellWithIdentifier:@"logDestailCell"];
            if (!cell) {
                  
                  cell = [[LogDestailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"logDestailCell"];
            }
            
            if (indexPath.section == 0) {
                  cell.numLab.text = @"值        长:";
                  cell.describeLab.text = @"状        态:";
                  cell.performLab.text = @"值        别:";
                  cell.postLab.text = @"班        次:";
                  cell.pWhyLab.text = @"机组组长:";
//                  NSArray *ary = self.leftDataAry[0];
//                  LogFrameModel  *frameModel = ary[indexPath.row];
//                  cell.logFrame = frameModel;
                  
                  
            }if (indexPath.section == 1) {
                  
                  
                  cell.numLab.text = @"编       号:";
                  cell.describeLab.text = @"描述内容:";
                  cell.performLab.text = @"执行说明:";
                  cell.postLab.text = @"顺       延:";
                  cell.pWhyLab.text = @"顺延原因:";
                 
                             }
             NSArray *ary = self.leftDataAry[indexPath.section];
            LogFrameModel  *frameModel = ary[indexPath.row];
            cell.logFrame = frameModel; 

            return cell;
            
      }else{
            
            
            if (indexPath.section == 0) {
                  
                  LogDestailCell*cell = [tableView dequeueReusableCellWithIdentifier:@"logDestailCell"];
                  if (!cell) {
                        
                        cell = [[LogDestailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"logDestailCell"];
                  }
                  
                  cell.numLab.text = @"值        长:";
                  cell.describeLab.text = @"状        态:";
                  cell.performLab.text = @"值        别:";
                  cell.postLab.text = @"班        次:";
                  cell.pWhyLab.text = @"机组组长:";

                  NSArray *ary = self.rightDataAry[0];
                  LogFrameModel  *frameModel = ary[indexPath.row];
                  cell.logFrame = frameModel;
                  return cell;
                  
                  
            }else  {
                  
                  LogDestailLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"logDetailLeftCell"];
                  if (!cell) {
                        cell = [[LogDestailLeftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"logDetailLeftCell"];
                  }
                  cell.numLab.text = @"时    间:";
                  cell.describeLab.text = @"内    容:";
                  //                  cell.performLab.hidden = YES;
                  //                  cell.postLab.hidden = YES;
                  //                  cell.pWhyLab.hidden = YES;
                  
                  NSArray *ary = self.rightDataAry[1];
                  LogDestailLeftModel  *frameModel = ary[indexPath.row];
                  cell.logFrame = frameModel;
                  
                  return cell;
            }
            
      }
      
      
      //      return cell;
      
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
      return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
      
      
      if (section == 0) {
            
            UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, _width-40, 50)];
            headView.backgroundColor = kUIColorFromRGB(0xfafafa);
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, _width*0.5, 50)];
            [headView addSubview:lab];
            
            lab.backgroundColor = kUIColorFromRGB(0xfafafa);
            lab.textColor = kUIColorFromRGB(0x1f9d85);
            lab.font = [UIFont systemFontOfSize:17];
            lab.textAlignment = NSTextAlignmentLeft;
            lab.text = @"日志记录";
            
            LogFrameModel *frameMomdel = self.leftDataAry[section][0];
            LogDestailModel *desMomdel = frameMomdel.logDestailModel;
            UILabel *wetLab = [[UILabel alloc] initWithFrame:CGRectMake(headView.width - 70,5, 30, 20)];
            [headView addSubview:wetLab];
            wetLab.text = @"天气";
           
            wetLab.textColor = kUIColorFromRGB(0x999999);
            wetLab.font = [UIFont systemFontOfSize:14];
            wetLab.textAlignment = NSTextAlignmentCenter;
            
            UILabel *wetLeftLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(wetLab.frame), 5, 40, 20)];
            [headView addSubview:wetLeftLab];
            wetLeftLab.textColor = kUIColorFromRGB(0xfd9602);
           // wetLeftLab.text = @"晴";
            self.wetLeftLab = wetLeftLab;
             wetLeftLab.text = desMomdel.weather;
            wetLeftLab.font = [UIFont systemFontOfSize:14];
            wetLeftLab.textAlignment = NSTextAlignmentRight;
            
            UILabel *dateLab = [[UILabel alloc] initWithFrame:CGRectMake(headView.width -150, CGRectGetMaxY(wetLeftLab.frame), 150, 25)];
            [headView addSubview:dateLab];
          //  dateLab.text = @"2016-12-10 8:00";
            dateLab.text = desMomdel.headDate;
            self.dateLab = dateLab;
            dateLab.textColor = kUIColorFromRGB(0x999999);
            dateLab.font = [UIFont systemFontOfSize:14];
            dateLab.textAlignment = NSTextAlignmentRight;
            return headView;
            
      }else{
            
            UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, 50)];
            headView.backgroundColor = kUIColorFromRGB(0xfafafa);
            UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, (headView.width )*0.5, 48)];
            [headView addSubview:leftBtn];
            self.leftBtn = leftBtn;
            leftBtn.tag = 103;
            [leftBtn addTarget:self action:@selector(changeBtn:) forControlEvents:UIControlEventTouchUpInside];
            [leftBtn setTitle:@"定期内容" forState:UIControlStateNormal];
            leftBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            leftBtn.backgroundColor = kUIColorFromRGB(0xfafafa);
            [leftBtn setTitleColor:kUIColorFromRGB(0x666666) forState:UIControlStateNormal];
            
            leftBtn.titleLabel.font = [UIFont systemFontOfSize:17];
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftBtn.frame), 9, 1, 30)];
            lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
            [headView addSubview:lineView];
            
            UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lineView.frame), 0, (headView.width - 20)*0.5, 48)];
            [headView addSubview:rightBtn];
            self.rightBtn = rightBtn;
            rightBtn.tag = 104;
            [rightBtn addTarget:self action:@selector(changeBtn:) forControlEvents:UIControlEventTouchUpInside];
            [rightBtn setTitle:@"记事内容" forState:UIControlStateNormal];
            rightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            rightBtn.backgroundColor = kUIColorFromRGB(0xfafafa);
            [rightBtn setTitleColor:kUIColorFromRGB(0x666666) forState:UIControlStateNormal];
            
            rightBtn.titleLabel.font = [UIFont systemFontOfSize:17];
            
            UIView *backLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(rightBtn.frame), headView.width*0.5, 2)];
            backLineView.backgroundColor = kUIColorFromRGB(0x1f9d85);
            self.lineView = backLineView;
            [headView addSubview:backLineView];
            if (self.isHiden) {
                  
                  [leftBtn setTitleColor:kUIColorFromRGB(0x1f9d85) forState:UIControlStateNormal];
                  [UIView animateWithDuration:0.25 animations:^{
                        self.lineView.x = 0;
                  }];
                  
            }else{
                  
                  [rightBtn setTitleColor:kUIColorFromRGB(0x1f9d85) forState:UIControlStateNormal];
                  [UIView animateWithDuration:0.25 animations:^{
                        self.lineView.x = _width *0.5;
                  }];
                  
                  
                  
            }
            
            
            //            //先生成存放标题的数据
            //            NSArray *array = [NSArray arrayWithObjects:@"本班定期工作内容",@"记事内容", nil];
            //            //初始化UISegmentedControl
            //            UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:array];
            //            //设置frame
            //            segment.frame = CGRectMake(0, 5,_width -40,40);
            //            segment.selectedSegmentIndex = 0;
            //            //添加到视图
            //           // [self.view addSubview:segment];
            //            [segment addTarget:self action:@selector(didseletSegment:) forControlEvents:UIControlEventValueChanged];
            
            return headView;
      }
      
      
      
}

- (void)changeBtn:(UIButton *)sender{
      if (sender.tag == 103) {
            self.isHiden = YES;
            [self.leftBtn setTitleColor:kUIColorFromRGB(0x1f9d85) forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:kUIColorFromRGB(0x666666) forState:UIControlStateNormal];
            [UIView animateWithDuration:0.25 animations:^{
                  self.lineView.x = 0;
            }];
            
      }if (sender.tag == 104) {
            self.isHiden = NO;
            
            [self.rightBtn setTitleColor:kUIColorFromRGB(0x1f9d85) forState:UIControlStateNormal];
            [self.leftBtn setTitleColor:kUIColorFromRGB(0x666666) forState:UIControlStateNormal];
            [UIView animateWithDuration:0.25 animations:^{
                  self.lineView.x = _width *0.5;
            }];
            
      }
      
      [self.tableView reloadData];
}
- (void)didseletSegment:(UISegmentedControl *)segment{
      
      
}
//- (UIView *)headView{
//      
//      CGFloat viewH = 30;
//      UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 180)];
//      
//      for (int i = 0; i<6;i++) {
//            
//            LogLab *labView = [[LogLab alloc] initWithFrame:CGRectZero];
//            labView.backgroundColor = [UIColor clearColor];
//            labView.frame = CGRectMake(10, viewH*i, headView.width, viewH);
//            [headView addSubview:labView];
//            if (i == 0) {
//                  
//                  labView.lLab.text = @"值长:";
//                  labView.rLab.text = @"张三";
//                  
//            }
//            if (i == 1) {
//                  labView.lLab.text = @"状态:";
//                  labView.rLab.text = @"已接班";
//                  
//            }
//            
//            if (i == 2) {
//                  
//                  labView.lLab.text = @"职别:";
//                  labView.rLab.text = @"四值";
//                  
//            }
//            
//            if (i == 3) {
//                  
//                  labView.lLab.text = @"班次:";
//                  labView.rLab.text = @"16：00：00 - 16：00：00";
//            }
//            
//            if (i == 4) {
//                  labView.lLab.text = @"一号机组长:";
//                  labView.rLab.text = @"ssxx";
//            }if (i == 5) {
//                  labView.lLab.text = @"日期:";
//                  labView.rLab.text = @"2016-11-21";
//            }
//            
//            
//            
//      }
//      
//      
//      return headView;
//      
//}
//

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
