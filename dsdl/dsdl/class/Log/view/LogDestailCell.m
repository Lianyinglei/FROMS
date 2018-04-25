//
//  LogDestailCell.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/28.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "LogDestailCell.h"
#import "LogLab.h"
#import "NSString+Extension.h"
#import "LogFrameModel.h"
#import "LogDestailModel.h"

@interface LogDestailCell ()





@end

@implementation LogDestailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
      if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
            
            
            UIFont *font = [UIFont systemFontOfSize:14];
            UIColor *textColor = kUIColorFromRGB(0x666666);
            UIColor *leftColor = kUIColorFromRGB(0x333333);
            
            //编号
            UILabel *numLab = [[UILabel alloc] init];
            [self.contentView addSubview:numLab];
            self.numLab = numLab;
            self.numLab.font = font;
            self.numLab.textColor = leftColor;
            
            UILabel *numLabR = [[UILabel alloc] init];
            [self.contentView addSubview:numLabR];
            self.numLabR = numLabR;
            self.numLabR.textColor = textColor;
            self.numLabR.font = font;
            
            //描述内容
            UILabel *describeLab = [[UILabel alloc] init];
            [self.contentView addSubview:describeLab];
            self.describeLab = describeLab;
            self.describeLab.font = font;
            self.describeLab.textColor = leftColor;
            
            UILabel *describeLabR = [[UILabel alloc] init];
            [self.contentView addSubview:describeLabR];
            self.describeLabR = describeLabR;
            self.describeLabR.textColor = textColor;
            self.describeLabR.font = font;
            self.describeLabR.numberOfLines = 0;
            
            
            //执行说明
            UILabel *performLab = [[UILabel alloc] init];
            [self.contentView addSubview:performLab];
            self.performLab = performLab;
            self.performLab.font = font;
            self.performLab.textColor = leftColor;
            
            UILabel *performLabR = [[UILabel alloc] init];
            [self.contentView addSubview:performLabR];
            self.performLabR = performLabR;
            self.performLabR.textColor = textColor;
            self.performLabR.font = font;
            self.performLabR.numberOfLines = 0;
//            self.performLabR.textAlignment = NSTextAlignmentLeft;
            
            //顺延
            
            UILabel *postLab = [[UILabel alloc] init];
            [self.contentView addSubview:postLab];
            self.postLab = postLab;
            self.postLab.font = font;
            self.postLab.textColor = leftColor;
            
            UILabel *postLabR = [[UILabel alloc] init];
            [self.contentView addSubview:postLabR];
            self.postLabR = postLabR;
            self.postLabR.textColor = textColor;
            self.postLabR.font = font;
            
            //顺延原因
            
            UILabel *pWhyLab = [[UILabel alloc] init];
            [self.contentView addSubview:pWhyLab];
            self.pWhyLab = pWhyLab;
            self.pWhyLab.font = font;
            self.pWhyLab.textColor = leftColor;
            
            UILabel *pWhyLabR = [[UILabel alloc] init];
            [self.contentView addSubview:pWhyLabR];
            self.pWhyLabR = pWhyLabR;
            self.pWhyLabR.textColor = textColor;
            self.pWhyLabR.font = font;
            self.pWhyLabR.numberOfLines = 0;
            
            //底部颜色
            UIView *colorView = [[UIView alloc] initWithFrame:CGRectZero];
            [self.contentView addSubview:colorView];
            colorView.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1.0];
            self.colorView = colorView;
           

            
            
            
            
            
            
            
            
            
//            LogLab *bianLab = [[LogLab alloc] initWithFrame: CGRectZero];
//            ;
//            [self.contentView addSubview:bianLab];
//            
//              self.numLab =bianLab.rLab;
//            
//            LogLab *miaoLab = [[LogLab alloc] initWithFrame:CGRectZero];
//            [self.contentView addSubview:miaoLab];
//            //      miaoLab.frame = CGRectMake(leftMar, CGRectGetMaxY(bianLab.frame), viewW, labSize.height);
//            miaoLab.rLab.numberOfLines = 0;
//           
//            self.describeLab = miaoLab.rLab;
//
//            
//            
//            //顺延
//            LogLab *slab = [[LogLab alloc] initWithFrame:CGRectZero];
//            slab.lLab.text = @"执行说明:";
//           // slab.rLab.text = @"N";
//            self.performLab = slab.rLab;
//            [self.contentView addSubview:slab];
//            
//            
//            NSString *reasonStr = @"顺延的原因我也不知道，我也真不会到，顺延原因，测试自动换行哦";
//            LogLab *reasonLab = [[LogLab alloc] initWithFrame:CGRectZero];
//            [self.contentView addSubview:reasonLab];
//            reasonLab.rLab.numberOfLines = 0;
//            reasonLab.lLab.text = @"顺延原因:";
//        
//            self.pWhyLab = reasonLab.rLab;


            
      }

      return self;
}


- (void)setLogFrame:(LogFrameModel *)logFrame{
      _logFrame = logFrame;
      
      self.numLab.frame = logFrame.numLabF;
      self.numLabR.frame = logFrame.numLabRF;
      
      self.describeLab.frame = logFrame.describLabF;
      self.describeLabR.frame = logFrame.describLabRF;
      
      self.performLab.frame = logFrame.performF;
      self.performLabR.frame = logFrame.performRF;
      
      self.postLab.frame = logFrame.postLabF;
      self.postLabR.frame = logFrame.postLabRF;
      
      self.pWhyLab.frame = logFrame.pWhyLabF;
      self.pWhyLabR.frame = logFrame.pWhyLabRF;
      
      self.colorView.frame = logFrame.colorViewF;
      
      
      
      
      self.numLabR.text = logFrame.logDestailModel.no;
      self.describeLabR.text = logFrame.logDestailModel.contentDescribe;
      self.performLabR.text = logFrame.logDestailModel.executeExplain;
      self.postLabR.text = logFrame.logDestailModel.extended;
      self.pWhyLabR.text = logFrame.logDestailModel.extendedReason;

      
      
      

      

}
@end
