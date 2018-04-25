//
//  ProfitContentView.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/8.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "ProfitContentView.h"
#import "ProfitTableViewCell.h"
@interface ProfitContentView ()<UITableViewDelegate,UITableViewDataSource>



@property (nonatomic, weak) UITableView *profitView;



@end

@implementation ProfitContentView

- (void)setDataAry:(NSArray *)dataAry{

      _dataAry = dataAry;
      
      [self.profitView reloadData];
}

- (void)setProfitAry:(NSArray *)profitAry{

      _profitAry = profitAry;
      
}


- (instancetype)initWithFrame:(CGRect)frame{

      if (self = [super initWithFrame:frame]) {
            self.backgroundColor = [UIColor clearColor];
            [self creatProfitView];
      }
      return self;
}

- (void)setIsFule:(BOOL)isFule{

      _isFule = isFule;
     // self.profitView.rowHeight = 25;
      [self.profitView reloadData];
}
//利润表格
- (void)creatProfitView{
    
      
      UITableView *profitView = [[UITableView alloc] initWithFrame:self.bounds];
      [self addSubview:profitView];
      profitView.delegate = self;
      profitView.dataSource = self;
      self.profitView = profitView;
      profitView.scrollEnabled = NO;
      profitView.separatorStyle = UITableViewCellSeparatorStyleNone;
      
      profitView.backgroundColor = [UIColor clearColor];
      
      
      
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

      if (self.isPorfit) {
            if (_width == IPHONE5W) {
                  return 25;
            }else{
            
                   return 30;
            }
           
      }else if (self.isFule){
            
            
                  
                  return 30;
            
            
      }else{
      
            return 30;
      }
//      if (self.isPorfit) {
//            profitView.rowHeight = 25;
//      } else if (self.isFule) {
//            
//            profitView.rowHeight = 20;
//      }
//      else{
//            profitView.rowHeight = 30;
//            
//      }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
      UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 40)];
      
     // lab.textColor = kUIColorFromRGB(0x11afea);
      
            
//            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:str1];
//      NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]};
//            [str setAttributes:dic range:NSMakeRange(0, 4)];
//      
//            lab.attributedText = str;
      
       lab.text = self.headStr;
      if (self.isPorfit) {
            lab.textColor = [UIColor blackColor];
           
            lab.font = [UIFont systemFontOfSize:16];
            lab.textAlignment = NSTextAlignmentLeft;
            
            NSLog(@"----%lu",(unsigned long)self.headStr.length);
            lab.textColor = kUIColorFromRGB(0x333333);
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self.headStr];
            [attrStr addAttribute:NSForegroundColorAttributeName
                            value:kUIColorFromRGB(0x999999)
                            range:NSMakeRange(4, 6)];
            [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(4, 6)];
            
            
            lab.attributedText = attrStr;
            
           // lab.font = [UIFont systemFontOfSize:17];
            lab.textAlignment = NSTextAlignmentLeft;
            
      }else if (self.isFule) {
            lab.textColor = [UIColor whiteColor];
            
            lab.font = [UIFont systemFontOfSize:16];
            lab.textAlignment = NSTextAlignmentCenter;
            if (_width == IPHONE5W) {
                  lab.font = [UIFont systemFontOfSize:14];
            }
      }
      else{
            
           //self.headStr =  @"     日利润  (万元)";
            NSLog(@"----%lu",(unsigned long)self.headStr.length);
            lab.font = [UIFont systemFontOfSize:17];
            lab.textColor = kUIColorFromRGB(0x333333);
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self.headStr];
            [attrStr addAttribute:NSForegroundColorAttributeName
                            value:kUIColorFromRGB(0x999999)
                            range:NSMakeRange(11, 4)];
            [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(11, 4)];
            
      
            lab.attributedText = attrStr;
            
            
            lab.textAlignment = NSTextAlignmentLeft;
            
            
      
      }
   //  lab.textAlignment = NSTextAlignmentCenter;

      
      return lab;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
      if (self.isPorfit) {
            return 40;
      }else if (self.isFule) {
            if (_width == IPHONE5W) {
                  return 30;
            }else{
            
                   return 40;
            }
           
      }
      else{
      
            return 50;
      }
      
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      return self.profitAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
      
      ProfitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfitCell"];
      if (!cell) {
            
            cell = [[NSBundle mainBundle] loadNibNamed:@"ProfitTableViewCell" owner:self options:nil].lastObject;
      }
      if (self.isPorfit) {
            cell.destaiLab.textColor = [UIColor blackColor];
            cell.numLab.textColor = [UIColor blackColor];
            cell.destaiLab.font = [UIFont systemFontOfSize:13];
            cell.numLab.font = [UIFont systemFontOfSize:13];
            cell.destaiLab.textAlignment =  NSTextAlignmentCenter;
            cell.numLab.textAlignment = NSTextAlignmentCenter;
            cell.lineView.hidden = NO;
           
            if (indexPath.row == 0) {
                  cell.lineView.backgroundColor =kUIColorFromRGB(0x0ead6b);
                  
            }
            if (indexPath.row == 1) {
                  cell.lineView.backgroundColor = kUIColorFromRGB(0xff562f);
            }
            
            if (indexPath.row == 2) {
            cell.lineView.backgroundColor =kUIColorFromRGB(0xfd9602);            }
            if (indexPath.row == 3) {
            cell.lineView.backgroundColor =kUIColorFromRGB(0x00a5d3);
            }
            
            
            
      } else if (self.isFule) {
            cell.destaiLab.textColor = [UIColor whiteColor];
            cell.numLab.textColor = [UIColor whiteColor];
            cell.destaiLab.font = [UIFont systemFontOfSize:13];
            cell.numLab.font = [UIFont systemFontOfSize:13];
            cell.destaiLab.textAlignment = NSTextAlignmentCenter;
            cell.numLab.textAlignment = NSTextAlignmentCenter;
            cell.lineViewW.constant = 0.5;
            cell.lineView.hidden = YES;
//            if (_width == IPHONE5W) {
//                  cell.destaiLab.font = [UIFont systemFontOfSize:12];
//                  cell.numLab.font = [UIFont systemFontOfSize:12];
//            }
            
      }else{
            
            cell.destaiLab.font = [UIFont systemFontOfSize:17];
            cell.numLab.font = [UIFont systemFontOfSize:17];
            cell.destaiLab.textColor = kUIColorFromRGB(0x333333);
            cell.numLab.textColor = kUIColorFromRGB(0x333333);
            cell.numLab.textAlignment = NSTextAlignmentLeft;
            cell.lineView.hidden = YES;
      }
     
      
      cell.destaiLab.text = self.profitAry[indexPath.row];
    //  cell.numLab.text = [NSString stringWithFormat:@"%.2f",[ self.dataAry[indexPath.row] floatValue]];
      if ([self.dataAry[indexPath.row] isEqualToString:@"-"]) {
            cell.numLab.text = @"-";
      }else{
      
             cell.numLab.text = [Tools getNumberTwo:self.dataAry[indexPath.row]];
      }
     
      cell.contentView.backgroundColor = [UIColor clearColor];
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
      if (self.isFule) {
            
            if (indexPath.row !=0) {
                  
                  if ([self.dataAry[indexPath.row] isEqualToString:@"-"]) {
                        cell.numLab.text = [@"-" stringByAppendingString:@"%"];
                  }else{
                        
//                         cell.numLab.text = [[NSString stringWithFormat:@"%.2f",[ self.dataAry[indexPath.row] floatValue]] stringByAppendingString:@"%"];
                        cell.numLab.text = [[Tools getNumberTwo:self.dataAry[indexPath.row]] stringByAppendingString:@"%"];
                  }
//                  cell.destaiLab.text = [self.profitAry[indexPath.row] stringByAppendingString:@"%"];
                 
            }
           
      }
      
      if (self.isPorfit) {
            
            if (indexPath.row >1) {
                  
                  
                         cell.numLab.text = [[Tools getNumberTwo:self.dataAry[indexPath.row]] stringByAppendingString:@"%"];
                  
                 
            }
      }
     //  NSLog(@"----%@",self.profitAry[indexPath.row]);
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
