//
//  LogDestailLeftModel.m
//  dsdl
//
//  Created by 廉英雷 on 16/12/9.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "LogDestailLeftModel.h"
#import "NSString+Extension.h"
#import "LogDestailModel.h"

@implementation LogDestailLeftModel

- (void)setLogDestailModel:(LogDestailModel *)logDestailModel{
      
      _logDestailModel = logDestailModel;
      
      CGFloat leftMar = 10;
      CGFloat cellW = _width - 10;
      CGFloat labW = 80;
      CGFloat labH = 30;
      self.numLabF = CGRectMake(leftMar, 0, labW, labH);
      self.numLabRF = CGRectMake(CGRectGetMaxX(self.numLabF), self.numLabF.origin.y, cellW-labW, labH);
      
      //  NSString *str = @"此地是描述内容此地是描述内容此地是描述内容此地是描述内容此地是描述内容此地是描述内容此地是描述内容";
      CGSize describSize = [logDestailModel.context sizeWithFont:[UIFont systemFontOfSize:14] maxW:cellW - labW];
      self.describLabF = CGRectMake(leftMar, CGRectGetMaxY(self.numLabF), labW, describSize.height+10);
      self.describLabRF = CGRectMake(CGRectGetMaxX(self.describLabF), self.describLabF.origin.y, cellW-labW, describSize.height+10);
      
      self.colorViewF = CGRectMake(0, CGRectGetMaxY(self.describLabRF), _width, 10);


      self.cellHight = CGRectGetMaxY(self.colorViewF);
      
}

@end
