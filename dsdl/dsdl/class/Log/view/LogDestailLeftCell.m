//
//  LogDestailLeftCell.m
//  dsdl
//
//  Created by 廉英雷 on 16/12/9.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "LogDestailLeftCell.h"
#import "LogDestailLeftModel.h"
#import "LogDestailModel.h"

@implementation LogDestailLeftCell

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
            
            //底部颜色
            UIView *colorView = [[UIView alloc] initWithFrame:CGRectZero];
            [self.contentView addSubview:colorView];
            colorView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
            self.colorView = colorView;
      }
      return self;
}


- (void)setLogFrame:(LogDestailLeftModel *)logFrame{
      
      _logFrame = logFrame;
      
      self.numLab.frame = logFrame.numLabF;
      self.numLabR.frame = logFrame.numLabRF;
      
      
      self.describeLab.frame = logFrame.describLabF;
      self.describeLabR.frame = logFrame.describLabRF;
      
      self.colorView.frame = logFrame.colorViewF;

      self.numLabR.text = logFrame.logDestailModel.dateTime;
      
      self.describeLabR.text = logFrame.logDestailModel.context;
}
@end
