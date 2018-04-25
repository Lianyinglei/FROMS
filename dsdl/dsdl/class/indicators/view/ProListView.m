//
//  ProListView.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/25.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "ProListView.h"
#import "ProListTableViewCell.h"
#import "ProModel.h"
@interface ProListView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UITableView *tabView;


@end

@implementation ProListView

- (void)setTextAry:(NSArray *)textAry{

      _textAry = textAry;
    //  [self.tabView reloadData];
}

- (void)setDataAry:(NSArray *)dataAry{

      _dataAry = dataAry;
      [self.tabView reloadData];
}
//- (NSArray *)textAry{
//
//      if (!_textAry) {
//            _textAry = @[@"SOx",@"NOx",@"烟尘",@"脱硫效率",@"脱硝效率"];
//      }
//      return _textAry;
//}

- (instancetype)initWithFrame:(CGRect)frame{

      if (self = [super initWithFrame:frame]) {
            [self creatView];
      }
      return self;
}

- (void)creatView{

      UITableView *tabView = [[UITableView alloc] initWithFrame:self.bounds];
      self.tabView = tabView;
      tabView.delegate = self;
      tabView.dataSource = self;
      [self addSubview:tabView];
   
      tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
      if (_width == IPHONE5W) {
               tabView.rowHeight = 44;
      }else{
      
        tabView.rowHeight = 50;
      }
   //   tabView.tableHeaderView = [self creatHeadView];

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
      if (_width == IPHONE5W) {
            return 40;
      }else{
       return 60;
      }
     
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
      
      CGFloat headWidth = 60;
      if (_width == IPHONE5W) {
            headWidth= 40;}else{
            
                  headWidth = 60;
            }

      UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, headWidth)];
      headView.backgroundColor = kUIColorFromRGB(0x197e6b);
      CGFloat width = headView.width/5;
      UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width-2, headView.height)];
      [headView addSubview:leftLab];
      leftLab.text = @"指标";
      leftLab.textAlignment = NSTextAlignmentCenter;
      leftLab.textColor = [UIColor whiteColor];
      leftLab.font = [UIFont systemFontOfSize:15];
      UILabel *oneLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftLab.frame), 0, width *2+2, headView.height *0.5)];
      [headView addSubview:oneLab];
      oneLab.text = @"1#机组";
      oneLab.textAlignment = NSTextAlignmentCenter;
      oneLab.textColor = [UIColor whiteColor];
      oneLab.font = [UIFont systemFontOfSize:15];
      oneLab.backgroundColor = kUIColorFromRGB(0x1f9d85);
      
      UILabel *   twoLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(oneLab.frame), 0, width *2+2, headView.height *0.5)];
      [headView addSubview:twoLab];
      twoLab.text = @"2#机组";
      twoLab.textAlignment = NSTextAlignmentCenter;
      twoLab.textColor = [UIColor whiteColor];
      twoLab.font = [UIFont systemFontOfSize:15];
      twoLab.backgroundColor = kUIColorFromRGB(0x1f9d85);
      for (int i = 0; i<4; i++) {
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake((i+1)*width-2, CGRectGetMaxY(oneLab.frame), width+2, headView.height*0.5)];
            lab.textColor = [UIColor whiteColor];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.font = [UIFont systemFontOfSize:15];
            lab.backgroundColor = kUIColorFromRGB(0x64bbab);
            if (self.isImport) {
                  if (i%2) {
                        lab.text = @"昨日平均";
                  }else{
                        
                        lab.text = @"今日实时";
                  }
                  headView.backgroundColor = [UIColor colorWithRed:57/255.0 green:143/255.0 blue:114/255.0 alpha:1];
                  leftLab.backgroundColor =[UIColor colorWithRed:44/255.0 green:110/255.0 blue:90/255.0 alpha:1];
                  leftLab.text = @"重要参数";
                  lab.backgroundColor =  [UIColor colorWithRed:57/255.0 green:143/255.0 blue:114/255.0 alpha:1];
                  oneLab.backgroundColor =  [UIColor colorWithRed:57/255.0 green:143/255.0 blue:114/255.0 alpha:1];
                  twoLab.backgroundColor =  [UIColor colorWithRed:57/255.0 green:143/255.0 blue:114/255.0 alpha:1];
                  

            }else{
            
                  if (i%2) {
                        lab.text = @"上限值";
                  }else{
                        
                        lab.text = @"值";
                  }
                  
            }
           
            
            [headView addSubview:lab];
      }
      
      
      
      return headView;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

      return self.dataAry.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

      
      ProListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Procell"];
      if (!cell) {
            
            cell = [[NSBundle mainBundle] loadNibNamed:@"ProListTableViewCell" owner:self options:nil].lastObject;
      }
      
      //cell.indLab.backgroundColor = [UIColor colorWithRed:225/255.0 green:245/255.0 blue:254/255.0 alpha:1.0];
      cell.indLab.backgroundColor = kUIColorFromRGB(0xc9f3f4);
      cell.indLab.text = self.textAry[indexPath.row];
      cell.indLab.font = [UIFont systemFontOfSize:13];
      
      
      if (self.isImport) {
             cell.indLab.backgroundColor = [UIColor colorWithRed:147/255.0 green:225/255.0 blue:209/255.0 alpha:1.0];
            cell.hidden = NO;
            if (_width == IPHONE5W) {
                  cell.indLab.font = [UIFont systemFontOfSize:15];
            }
            
      }else{
      
       cell.indLab.backgroundColor = kUIColorFromRGB(0xc9f3f4);
      }
//      ProModel *model1 = self.dataAry[0];
//      ProModel*model2 = self.dataAry[1];
      NSArray *ary = self.dataAry[indexPath.row];
//      cell.oneValueLab.text = [NSString stringWithFormat:@"%.2f", [ary[0] floatValue]];
//     
//      cell.oneMaxLab.text = [NSString stringWithFormat:@"%.2f", [ary[1] floatValue]];
//     
//      cell.twoValueLab.text = [NSString stringWithFormat:@"%.2f", [ary[2] floatValue]];
//     
//      cell.twoMaxLab.text = [NSString stringWithFormat:@"%.2f", [ary[3] floatValue]];
      
       cell.oneValueLab.text = [Tools getNumberTwo:ary[0]];
       cell.oneMaxLab.text = [Tools getNumberTwo:ary[1]];
       cell.twoValueLab.text = [Tools getNumberTwo:ary[2]];
      cell.twoMaxLab.text = [Tools getNumberTwo:ary[3]];
      
      if (indexPath.row == 3 || indexPath.row == 4 ) {
            cell.oneMaxLab.text = @"-";
            cell.twoMaxLab.text = @"-";
      }
      
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
      
//      if (_width == IPHONE5W) {
//            cell.oneValueLab.font = [UIFont systemFontOfSize:14];
//            cell.oneMaxLab.font = [UIFont systemFontOfSize:14];
//            cell.twoValueLab.font = [UIFont systemFontOfSize:14];
//            cell.twoMaxLab.font = [UIFont systemFontOfSize:14];
//      }
//      if (_width == IPHONE6W) {
//            cell.oneValueLab.font = [UIFont systemFontOfSize:14];
//            cell.oneMaxLab.font = [UIFont systemFontOfSize:14];
//            cell.twoValueLab.font = [UIFont systemFontOfSize:14];
//            cell.twoMaxLab.font = [UIFont systemFontOfSize:14];
//      }
 
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
