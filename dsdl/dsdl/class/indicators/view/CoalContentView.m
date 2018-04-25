//
//  CoalContentView.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/16.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "CoalContentView.h"
#import "CoalTableViewCell.h"

@interface CoalContentView ()<UITableViewDataSource,UITableViewDelegate>



@property (nonatomic,weak) UITableView *tabView;

@end

@implementation CoalContentView

//- (void)viewDidLoad {
//      [super viewDidLoad];
//      // Do any additional setup after loading the view, typically from a nib.
//      [self setupRadarView];
//}

- (void)setDataAry:(NSArray *)dataAry{
      
      _dataAry = dataAry;
            
      [self.tabView reloadData];
}

- (void)setTextAry:(NSArray *)textAry{
      _textAry = textAry;
     // [self.tabView reloadData];

}
//- (NSArray *)textAry{
//      
//      if (!_textAry) {
//            _textAry = @[@"名称/单位",@"厂用电率(%)",@"炉侧厂用电(%)",@"机侧厂用电(%)",@"环保厂用电(%)",@"供热厂用电"];
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
      [self addSubview:tabView];
      tabView.delegate = self;
      tabView.dataSource = self;
      self.tabView = tabView;
      
      
      tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      
      return self.textAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
      if (_width == IPHONE5W) {
            return 40;
      }
       if (_width == IPHONE6W) {
            return 44;
      } if (_width == IPHONE6PW){
      
             return 50;
      }else{
            return 44;
      }
     
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
      
      CoalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"coalCell"];
      if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"CoalTableViewCell" owner:self options:nil].lastObject;
      }
      
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
      NSArray *ary = self.dataAry[indexPath.row];
      
      cell.coalLab.text = self.textAry[indexPath.row];
      cell.lineView.hidden = NO;
      
//      if (indexPath.row == 6) {
//            NSArray *ary1 = ary;
//            NSString *str1 = [Tools getNumberTwo:ary[0]];
//            
//             NSString *str2 = [Tools getNumberTwo:ary[1]];
//            
//      }
      if ([ary[0] isEqualToString: @""]) {
          
            cell.oneLab.text = @"-";
      }else{
           //  cell.oneLab.text = [NSString stringWithFormat:@"%.2f",[ary[0] floatValue]];
            cell.oneLab.text = [Tools getNumberTwo:ary[0]];
      
      }
      if ([ary[1] isEqualToString:@""]) {
            
            cell.twoLab.text = @"-";
      }else{
      
//       cell.twoLab.text = [NSString stringWithFormat:@"%.2f",[ary[1] floatValue]];
            
      cell.twoLab.text = [Tools getNumberTwo:ary[1]];
            
      }
     
     
      //cell.coalLab.backgroundColor = [UIColor clearColor];
      //cell.coalLab.textColor = [UIColor clearColor];
      cell.contentView.backgroundColor = [UIColor clearColor];
      cell.oneLab.backgroundColor = [UIColor clearColor];
      cell.twoLab.backgroundColor = [UIColor clearColor];
      cell.coalLab.backgroundColor = [UIColor clearColor];
      if (indexPath.row == 0) {
            if (self.isKey) {
            cell.contentView.backgroundColor = kUIColorFromRGB(0x02b4f0);
//                  cell.oneLab.text = @"1";
//                  cell.twoLab.text = @"2";
                  
            }else{
             cell.contentView.backgroundColor = themeColor;
                        
            }
           
            cell.oneLab.text = @"1#机组";
            cell.twoLab.text = @"2#机组";
            cell.oneLab.textColor = [UIColor whiteColor];
            cell.twoLab.textColor = [UIColor whiteColor];
            cell.coalLab.textColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = themeColor;
            
          //  cell.coalLab.backgroundColor = themeColor;
//            cell.oneLab.backgroundColor = themeColor;
//            cell.twoLab.backgroundColor = themeColor;
      }else{
            if (self.isKey) {
                  cell.coalLab.backgroundColor = kUIColorFromRGB(0xe7f7fd);
            }else{
            
                  cell.coalLab.backgroundColor = kUIColorFromRGB(0xa3e5d9);
            }
           
            cell.coalLab.textColor = [UIColor blackColor];
            cell.oneLab.textColor = [UIColor blackColor];
            cell.twoLab.textColor = [UIColor blackColor];
            cell.oneLab.backgroundColor = [UIColor whiteColor];
            cell.twoLab.backgroundColor = [UIColor whiteColor];
      }
      
      cell.oneLab.font = [UIFont systemFontOfSize:16];
      cell.twoLab.font = [UIFont systemFontOfSize:16];
      cell.coalLab.font = [UIFont systemFontOfSize:16];
      if (!self.isKey) {
            if (!indexPath.row == 0) {
                  NSString *str = self.textAry[indexPath.row];
                  
                  NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
                 
//                  [attrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(4, 7)];
                  cell.coalLab.attributedText = attrStr;

            }
                 }
      
      if (_width == IPHONE5W) {
            cell.oneLab.font = [UIFont systemFontOfSize:14];
            cell.twoLab.font = [UIFont systemFontOfSize:14];
            cell.coalLab.font = [UIFont systemFontOfSize:14];
      }
      
      return cell;
}

- (void)setupRadarView
{
      
}
@end
