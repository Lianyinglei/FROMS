//
//  TodoContentView.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/17.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "TodoContentView.h"
#import "TodoContentHeadView.h"
#import "TodoContentCell.h"
#import "NSString+Extension.h"
#import "TodoHeadModel.h"
#import "TodoDesModel.h"
@interface TodoContentView()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>

@property (nonatomic, weak) UITableView *tabView;

@property(nonatomic,strong) UITextView *contentView;

@property(nonatomic,strong) UILabel *placeholder;

@property (nonatomic, weak) UIButton *agreeBtn;

@property (nonatomic, weak) UIButton *disagreeBtn;



/**
 *  描述内容
 */
@property (nonatomic, copy) NSString *strContent;



@end

@implementation TodoContentView

- (instancetype)initWithFrame:(CGRect)frame{

      if (self = [super initWithFrame:frame]) {
         self.backgroundColor = [UIColor whiteColor];
            [self creatView];
            //监听键盘
             [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
      }
      
      return self;
}

- (void)setHeadAry:(NSMutableArray *)headAry{

      _headAry = headAry;
      
       self.tabView.tableHeaderView = [self headView];
}

- (void)setDataAry:(NSMutableArray *)dataAry{

      _dataAry = dataAry;
      
      [self.tabView reloadData];
}
- (void)creatView{

      UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds];
      [self addSubview:tableView];
      self.tabView = tableView;
      tableView.delegate = self;
      tableView.dataSource = self;
      tableView.rowHeight = 150;
      tableView.separatorStyle = UITableViewCellSelectionStyleNone;
      tableView.tableHeaderView = [self headView];
      tableView.tableFooterView = [self footerView];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

      return self.dataAry.count;
      
}



- (UIView *)headView{

      UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, 150)];
      TodoHeadModel *model = self.headAry[0];
      TodoContentHeadView *contentHeadView = [[NSBundle mainBundle] loadNibNamed:@"TodoContentHeadView" owner:self options:nil].lastObject;
      contentHeadView.frame = CGRectMake(0, 0, headView.width, 150);
      [headView addSubview:contentHeadView];
       NSLog(@"高度1------%f",headView.height);
      //"applyDepartment": 申请部门,
      //"applyMajor": 申请专业,
      //"applyPerson": 申请人,
      //"applyTime": 申请时间,
      //"budgetProject": 预算项目,
      //"commissionId": 待办列表id,
      //"createTime": 创建时间,
      //"describe": 描述,
      //"id": "",
      //"no": 编号,
      //"planTotal": 计划单总费用,
      //"status": 状态,
      //"type": 类别
      
      contentHeadView.nameLab.text = model.applyPerson;
      contentHeadView.nameLab.textColor = themeColor;
      contentHeadView.titleLab.textColor = kUIColorFromRGB(0xfa5900);
      contentHeadView.titleLab.text = model.details;
      contentHeadView.noLab.text = model.no;
      contentHeadView.sheLab.text = model.applyDepartment;
      contentHeadView.guoLab.text = model.applyMajor;
      contentHeadView.wuLab.text = model.type;
      contentHeadView.dateLab.text = model.applyTime;
      
     // NSString *str = @"描述:2016年一般检修材料费用等待审批和检验2016年一般检修材料费用等待审批和检验2016年一般检修材料费用等待审批和检验2016年一般检修材料费用等待审批和检验2016年一般检修材料费用等待审批和检验2016年一般检修材料费用等待审批和检验";
      if (model.taskDescribe.length>0) {
            
            model.taskDescribe = [@"描述:" stringByAppendingString:model.taskDescribe];
      }

      CGSize strSize = [model.taskDescribe sizeWithFont:[UIFont systemFontOfSize:15] maxW:_width - 10];
      
      UILabel *strLab = [[UILabel alloc] initWithFrame:CGRectMake(18, CGRectGetMaxY(contentHeadView.frame)+10, _width-15, strSize.height)];
      strLab.numberOfLines = 0;
      strLab.font = [UIFont systemFontOfSize:15];
      
      [headView addSubview:strLab];
      
      strLab.text = model.taskDescribe;
      
      UIView *backColorView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(strLab.frame)+10, _width, 10)];
      
      [headView addSubview:backColorView];
      backColorView.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1.0];
      
      headView.height = headView.height+strLab.height+10+backColorView.height;
      NSLog(@"高度2------%f",headView.height);
      return headView;

}

- (UIView *)footerView{

      UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, 240)];
      
      UILabel *lab4 = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, _width - 80, 40)];
      [footerView addSubview:lab4];
      lab4.font = [UIFont systemFontOfSize:15];
      lab4.textColor = kUIColorFromRGB(0x333333);
      lab4.textAlignment = NSTextAlignmentLeft;
      lab4.text = @"审批意见";
      
      UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(lab4.frame),footerView.width-40, 80)];
      headView.backgroundColor = [UIColor whiteColor];
      
      _contentView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, headView.width, headView.height)];
      _contentView.backgroundColor = [UIColor clearColor];
      _contentView.scrollEnabled = YES;
      _contentView.delegate = self;
      _contentView.font = [UIFont systemFontOfSize:17];
      _contentView.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1.0].CGColor;
      _contentView.layer.borderWidth = 0.6f;
      
      //placeholder
      _placeholder = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, headView.width, 25)];
      _placeholder.text = @"请输入审批意见";
      _placeholder.font = [UIFont systemFontOfSize:15];
      _placeholder.textColor = [UIColor lightGrayColor];
      _placeholder.enabled = NO;
      [headView addSubview:_placeholder];
      [headView addSubview:_contentView];
      [footerView addSubview:headView];
      
      UIButton * agreeBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(headView.frame)+13, 14, 14)];
      [agreeBtn setImage:[UIImage imageNamed:@"agreeNormal.png"] forState:UIControlStateNormal];
      agreeBtn.tag = 101;
      self.agreeBtn = agreeBtn;
      [agreeBtn addTarget:self action:@selector(agreeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
      
      
      [footerView addSubview:agreeBtn];
      
      UILabel *agreeLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(agreeBtn.frame)+2, CGRectGetMaxY(headView.frame)+5, 50, 30)];
      
      [footerView addSubview:agreeLab];
      agreeLab.font = [UIFont systemFontOfSize:13];
      agreeLab.textAlignment = NSTextAlignmentLeft;
      agreeLab.textColor = [UIColor blackColor];
      agreeLab.text = @"同意";
      agreeBtn.selected = NO;
      
      
      UIButton * disagreeBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(agreeLab.frame)+5, agreeBtn.y, 14, 14)];
      
      [disagreeBtn addTarget:self action:@selector(agreeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
      self.disagreeBtn = disagreeBtn;
      self.disagreeBtn.selected = NO;
       [disagreeBtn setImage:[UIImage imageNamed:@"agreeNormal.png"] forState:UIControlStateNormal];
      disagreeBtn.tag = 102;
      [footerView addSubview:disagreeBtn];
      
      UILabel *disagreeLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(disagreeBtn.frame)+2, agreeLab.y, 50, 30)];
      [footerView addSubview:disagreeLab];
      disagreeLab.font = [UIFont systemFontOfSize:13];
      disagreeLab.textAlignment = NSTextAlignmentLeft;
      disagreeLab.textColor = [UIColor blackColor];
      disagreeLab.text = @"不同意";
      
      
      UIButton *agreeBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(20,CGRectGetMaxY(disagreeBtn.frame)+30,footerView.width-40 ,40)];
      [footerView addSubview:agreeBtn1];
      [agreeBtn1 setTitle:@"提交" forState:UIControlStateNormal];
      agreeBtn1.backgroundColor = themeColor;
      [agreeBtn1 addTarget:self action:@selector(agreeBtnClick1) forControlEvents:UIControlEventTouchUpInside];
      agreeBtn1.layer.cornerRadius = 5;
      agreeBtn1.layer.masksToBounds = YES;
      

      return footerView;


}

- (void)agreeBtnClick1{
      
      
            if (self.agreeBtn.selected || self.disagreeBtn.selected) {
                  
                  if (self.agreeBtn.selected) {
                        self.contentBlock(_contentView.text,@"同意");
                  }
                  if (self.disagreeBtn.selected) {
                        self.contentBlock(_contentView.text,@"不同意");
                  }
                  
            }else{
                  
                  [[Tools shareTools] alert:@"请点击是否同意" :nil];
            }

      
     
}

- (void)agreeBtnClick:(UIButton *)sender{
     // BOOL isSelect = sender.selected;
      
      if (sender.tag ==101) {
             [sender setImage:[UIImage imageNamed:@"agreeSelect.png"] forState:UIControlStateNormal];
            sender.selected = YES;
            self.disagreeBtn.selected = NO;
           [self.disagreeBtn setImage:[UIImage imageNamed:@"agreeNormal.png"] forState:UIControlStateNormal];
            
      }if (sender.tag ==102) {
            sender.selected = YES;
            self.agreeBtn.selected = NO;
             [sender setImage:[UIImage imageNamed:@"agreeSelect.png"] forState:UIControlStateNormal];
            [self.agreeBtn setImage:[UIImage imageNamed:@"agreeNormal.png"] forState:UIControlStateNormal];
      }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

      
      TodoContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"todoContentCell"];
      if (!cell) {
            
            cell = [[NSBundle mainBundle] loadNibNamed:@"TodoContentCell" owner:self options:nil].lastObject;
      }
      
      TodoDesModel *model = self.dataAry[indexPath.row];
      cell.noLab.text = model.no;
      cell.kuLab.text = model.warehouse;
      cell.headLab.text = model.suppliesName;
      cell.desLab.text = model.unit;
      cell.danLab.text = model.unitCost;
      cell.numLab.text = model.demandTotal;
      cell.xingLab.text = model.lineCost;
      return cell;

}


//监听键盘的变化
- (void)textFieldChange:(NSNotification *) notification{
      
      NSLog(@"监听键盘的变化------%@",notification);
      NSDictionary *userInfo = [notification userInfo];
      NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
      CGRect keyboardRect = [aValue CGRectValue];
      
      
      
      keyboardRect = [self convertRect:keyboardRect fromView:nil];
      
      // 动画时长
      NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
      
      //      self.bottomView.viewHeight = [NSNumber numberWithFloat:_height -keyboardRect.size.height-44];
      if (_height == keyboardRect.origin.y+64) {
            
            [UIView animateWithDuration:duration animations:^{
                  self.tabView.frame = CGRectMake(0, 0, _width, _height -44);
                  
            }];
      }else{
            
            CGFloat he = _height;
            NSLog(@"高低-----%f",he);
            [UIView animateWithDuration:duration animations:^{
                  self.tabView.frame = CGRectMake(0, -keyboardRect.size.height+40, _width, _height - 44);
                  
            }];
            
      }
      
      
      
      
      
      
      
      //      UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 315}, {320, 253}}";
      //      UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 568}, {320, 253}}";
      
      
      //
      
      
}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
      
      [self endEditing:YES];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
      //NSLog(@"-----%lu----%@",(unsigned long)range.location,text);
      if (![text isEqualToString:@""])
      {
            _placeholder.hidden = YES;
      }else if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
      {
            _placeholder.hidden = NO;
            
      }
      
      if (range.location >100){
            NSLog(@"-----%lu",(unsigned long)range.location);
            //[self showTipView:@"不能超过最大输入数字100"];
            [[Tools shareTools] alert:@"不能超过最大输入数字100" :nil];
            return NO;
      }
      return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
      
      if (textView.text.length) {
            
            _placeholder.hidden = YES;
            
      }else{
            
            _placeholder.hidden = NO;
            
      }
      
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
